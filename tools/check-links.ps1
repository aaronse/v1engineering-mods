#Requires -Version 7.0
<#
.SYNOPSIS
    Verify every external link in one or more markdown/HTML files, and (optionally)
    ground V1 Engineering shop links against a local parts library.

.DESCRIPTION
    Built to keep docs in this repo honest — a BOM full of dead shop links is worse
    than no BOM.

    Output is deliberately terse so it is cheap to paste into an LLM context:
    by default you get one summary line per file plus ONE line per problem link.
    Healthy links print nothing. Use -All when you want the full listing.

    Checks performed per link:
      1. Live HTTP check (HEAD, falling back to GET for servers that reject HEAD).
      2. Redirect reporting — flags when the final URL differs from the one written.
      3. Offline grounding — if -LibraryPath is given, any
         v1e.com/products/<handle> link whose handle is missing from the library
         catalog is flagged. Catches BOM links to products that never existed.

    Statuses:
      OK        2xx, and the final URL matches what was written (or it's a shortener)
      REDIRECT  2xx but landed somewhere else — often a renamed or merged product
      BROKEN    404/410, another 4xx/5xx, or the request failed outright
      BLOCKED   401/403/429/503. Bot-blocking and auth walls are indistinguishable
                from a real break over HTTP, so these never fail the run — check by hand
      UNGROUNDED  Live check passed but the handle is absent from the local library

    Exit code is 1 if anything is BROKEN or UNGROUNDED, else 0.

.PARAMETER Path
    File(s) to scan. Accepts wildcards.

.PARAMETER LibraryPath
    Folder containing a V1E parts library (expects catalog.json with a
    products[] array of {url, title}). Enables the UNGROUNDED check.

.PARAMETER All
    Print every link, not just the problems.

.PARAMETER Json
    Emit results as JSON instead of the terse table.

.PARAMETER CachePath
    JSON cache of previous results. Links checked within -CacheHours are not
    re-requested. Defaults to <repo>/tools/.link-cache.json.

.PARAMETER NoCache
    Ignore and do not update the cache.

.PARAMETER SkipPattern
    Regex(es); matching URLs are not requested (still counted as skipped).

.EXAMPLE
    ./tools/check-links.ps1 zenxy-v3/README.md -LibraryPath E:\git\new-zenxy\models\library\v1e

.EXAMPLE
    ./tools/check-links.ps1 **/*.md -All -Json > link-report.json
#>
[CmdletBinding()]
param(
    [Parameter(Mandatory, Position = 0)][string[]]$Path,
    [string]$LibraryPath,
    [int]$ThrottleLimit = 8,
    [int]$TimeoutSec = 25,
    [switch]$All,
    [switch]$Json,
    [string]$CachePath,
    [int]$CacheHours = 24,
    [switch]$NoCache,
    [string[]]$SkipPattern
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# URL shorteners / vanity domains. A 2xx that lands elsewhere is the whole point
# of these, so don't cry REDIRECT at them.
$ShortenerHosts = @('amzn.to', 'a360.co', 'bit.ly', 'tinyurl.com', 'youtu.be', 'goo.gl')

if (-not $CachePath) { $CachePath = Join-Path $PSScriptRoot '.link-cache.json' }

function Get-LinksFromText {
    param([string]$Text)

    $found = [System.Collections.Generic.List[object]]::new()

    # Line number lookup so problems are clickable in an editor.
    $lines = $Text -split "`r?`n"

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $line = $lines[$i]
        $lineNo = $i + 1

        # Skip fenced-code content? No - links in code blocks still matter for docs.
        $patterns = @(
            # [text](https://...)  — stop at whitespace or the closing paren
            '\[[^\]]*\]\(\s*<?(?<u>https?://[^\s)>]+)'
            # [ref]: https://...
            '^\s*\[[^\]]+\]:\s*<?(?<u>https?://[^\s>]+)'
            # href="https://..." / src='https://...'
            '(?:href|src)\s*=\s*["'']?(?<u>https?://[^"''\s>]+)'
        )

        $seenOnLine = @{}
        foreach ($p in $patterns) {
            foreach ($m in [regex]::Matches($line, $p)) {
                $u = $m.Groups['u'].Value
                if (-not $seenOnLine.ContainsKey($u)) {
                    $seenOnLine[$u] = $true
                    $found.Add([pscustomobject]@{ Url = $u; Line = $lineNo })
                }
            }
        }

        # Bare URLs not already captured above.
        foreach ($m in [regex]::Matches($line, '(?<u>https?://[^\s)>\]"''`<]+)')) {
            $u = $m.Groups['u'].Value
            if (-not $seenOnLine.ContainsKey($u)) {
                $seenOnLine[$u] = $true
                $found.Add([pscustomobject]@{ Url = $u; Line = $lineNo })
            }
        }
    }

    # Trim trailing punctuation that markdown prose tends to glue on.
    foreach ($f in $found) {
        $f.Url = ($f.Url -replace '[.,;:!]+$', '') -replace '[)\]>"''`]+$', ''
    }

    $found
}

function Get-V1eHandle {
    param([string]$Url)
    $m = [regex]::Match($Url, '(?i)v1e(?:ngineering)?\.com/(?:collections/[^/]+/)?products/(?<h>[A-Za-z0-9\-_]+)')
    if ($m.Success) { return $m.Groups['h'].Value }
    return $null
}

# ---------- load library ----------
$libraryHandles = $null
if ($LibraryPath) {
    $catalog = Join-Path $LibraryPath 'catalog.json'
    if (-not (Test-Path $catalog)) {
        Write-Warning "No catalog.json under $LibraryPath - skipping grounding check."
    }
    else {
        $libraryHandles = @{}
        $cat = Get-Content $catalog -Raw | ConvertFrom-Json
        foreach ($p in $cat.products) {
            $h = Get-V1eHandle $p.url
            if ($h) { $libraryHandles[$h.ToLowerInvariant()] = $p.title }
        }
        Write-Verbose "Library: $($libraryHandles.Count) product handles loaded."
    }
}

# ---------- load cache ----------
$cache = @{}
if (-not $NoCache -and (Test-Path $CachePath)) {
    try {
        $raw = Get-Content $CachePath -Raw | ConvertFrom-Json
        foreach ($prop in $raw.PSObject.Properties) {
            $cache[$prop.Name] = $prop.Value
        }
    }
    catch { Write-Warning "Cache unreadable, ignoring: $CachePath" }
}
$cacheCutoff = (Get-Date).AddHours(-$CacheHours)

# ---------- gather ----------
$files = @()
foreach ($p in $Path) {
    $resolved = Get-ChildItem -Path $p -File -ErrorAction SilentlyContinue
    if (-not $resolved) { Write-Warning "No file matched: $p"; continue }
    $files += $resolved
}
if (-not $files) { throw 'No input files found.' }

$allLinks = [System.Collections.Generic.List[object]]::new()
foreach ($f in $files) {
    $text = Get-Content $f.FullName -Raw
    foreach ($l in (Get-LinksFromText $text)) {
        $allLinks.Add([pscustomobject]@{
                File = $f.FullName
                Line = $l.Line
                Url  = $l.Url
            })
    }
}

# Unique URLs actually needing a network round trip.
$unique = $allLinks | Select-Object -ExpandProperty Url -Unique
$toCheck = [System.Collections.Generic.List[string]]::new()
$results = @{}

foreach ($u in $unique) {
    if ($SkipPattern) {
        $skip = $false
        foreach ($sp in $SkipPattern) { if ($u -match $sp) { $skip = $true; break } }
        if ($skip) {
            $results[$u] = [pscustomobject]@{ Status = 'SKIPPED'; Code = 0; Final = $u; Note = 'matched -SkipPattern' }
            continue
        }
    }
    if (-not $NoCache -and $cache.ContainsKey($u)) {
        $entry = $cache[$u]
        if ([datetime]$entry.checkedAt -gt $cacheCutoff) {
            $results[$u] = [pscustomobject]@{ Status = $entry.status; Code = $entry.code; Final = $entry.final; Note = 'cached' }
            continue
        }
    }
    $toCheck.Add($u)
}

# ---------- check ----------
if ($toCheck.Count -gt 0) {
    $checked = $toCheck | ForEach-Object -ThrottleLimit $ThrottleLimit -Parallel {
        $u = $_
        $timeout = $using:TimeoutSec
        $shorteners = $using:ShortenerHosts

        $ua = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0 Safari/537.36'
        $code = 0; $final = $u; $note = ''

        function Invoke-Probe([string]$url, [string]$method) {
            Invoke-WebRequest -Uri $url -Method $method -MaximumRedirection 10 `
                -TimeoutSec $timeout -Headers @{ 'User-Agent' = $ua } `
                -SkipHttpErrorCheck -ErrorAction Stop
        }

        # Attempt 1 normally, attempt 2 with a doubled timeout. Slow shop/CDN hosts
        # blow a 25s budget often enough that a single timeout is not evidence.
        foreach ($attempt in 1, 2) {
            try {
                $r = Invoke-Probe $u 'Head'
                $code = [int]$r.StatusCode
                if ($code -in 403, 405, 501, 400) {
                    # Plenty of servers dislike HEAD. Retry properly before judging.
                    $r = Invoke-Probe $u 'Get'
                    $code = [int]$r.StatusCode
                }
                if ($r.BaseResponse -and $r.BaseResponse.RequestMessage -and $r.BaseResponse.RequestMessage.RequestUri) {
                    $final = $r.BaseResponse.RequestMessage.RequestUri.AbsoluteUri
                }
                $note = ''
                break
            }
            catch {
                $note = ($_.Exception.Message -replace '\s+', ' ')
                if ($note.Length -gt 90) { $note = $note.Substring(0, 90) }
                $code = 0
                $timeout = $timeout * 2
            }
        }

        $host_ = try { ([uri]$u).Host } catch { '' }
        $isShortener = $false
        foreach ($s in $shorteners) { if ($host_ -like "*$s") { $isShortener = $true; break } }

        $status =
        if ($code -ge 200 -and $code -lt 300) {
            # Normalise trailing slash / http->https before calling it a redirect.
            $a = ($u -replace '^http://', 'https://').TrimEnd('/')
            $b = ($final -replace '^http://', 'https://').TrimEnd('/')
            if ($a -eq $b -or $isShortener) { 'OK' } else { 'REDIRECT' }
        }
        elseif ($code -in 404, 410) { 'BROKEN' }
        # Bot-blocking (Cloudflare, Amazon, Akamai) and auth walls are indistinguishable
        # from a real break over plain HTTP, so never auto-fail on these.
        elseif ($code -in 401, 403, 429, 503) { 'BLOCKED' }
        else { 'BROKEN' }

        [pscustomobject]@{ Url = $u; Status = $status; Code = $code; Final = $final; Note = $note }
    }

    foreach ($c in $checked) {
        $results[$c.Url] = [pscustomobject]@{ Status = $c.Status; Code = $c.Code; Final = $c.Final; Note = $c.Note }
        if (-not $NoCache) {
            $cache[$c.Url] = [pscustomobject]@{
                status = $c.Status; code = $c.Code; final = $c.Final; checkedAt = (Get-Date).ToString('o')
            }
        }
    }
}

if (-not $NoCache) {
    $cache | ConvertTo-Json -Depth 5 | Set-Content -Path $CachePath -Encoding utf8
}

# ---------- grounding ----------
$rows = foreach ($l in $allLinks) {
    $r = $results[$l.Url]
    $status = $r.Status
    $note = $r.Note
    $handle = Get-V1eHandle $l.Url
    if ($handle -and $null -ne $libraryHandles) {
        if (-not $libraryHandles.ContainsKey($handle.ToLowerInvariant())) {
            if ($status -eq 'OK') { $status = 'UNGROUNDED' }
            $note = (@($note, "handle '$handle' not in local V1E library") | Where-Object { $_ }) -join '; '
        }
    }
    # Relative path, so sibling README.md files don't collapse into one another.
    $rel = try { (Resolve-Path -LiteralPath $l.File -Relative) -replace '^\.[\\/]', '' } catch { $l.File }

    [pscustomobject]@{
        File   = $rel
        Line   = $l.Line
        Status = $status
        Code   = $r.Code
        Url    = $l.Url
        Final  = $(if ($r.Final -ne $l.Url) { $r.Final } else { '' })
        Note   = $note
    }
}

# ---------- report ----------
if ($Json) {
    $rows | ConvertTo-Json -Depth 4
}
else {
    $order = @{ BROKEN = 0; UNGROUNDED = 1; REDIRECT = 2; BLOCKED = 3; SKIPPED = 4; OK = 5 }
    $problems = $rows | Where-Object { $_.Status -ne 'OK' } | Sort-Object { $order[$_.Status] }, File, Line
    $show = if ($All) { $rows | Sort-Object { $order[$_.Status] }, File, Line } else { $problems }

    foreach ($g in ($rows | Group-Object File)) {
        $c = $g.Group | Group-Object Status | ForEach-Object { "$($_.Name.ToLower())=$($_.Count)" }
        Write-Host ("{0}: {1} links | {2}" -f $g.Name, $g.Count, ($c -join ' '))
    }

    if ($show) {
        Write-Host ''
        $show | ForEach-Object {
            $colour = switch ($_.Status) {
                'BROKEN' { 'Red' }; 'UNGROUNDED' { 'Magenta' }; 'REDIRECT' { 'Yellow' }
                'BLOCKED' { 'DarkYellow' }; 'SKIPPED' { 'DarkGray' }; default { 'Green' }
            }
            $extra = @()
            if ($_.Final) { $extra += "-> $($_.Final)" }
            if ($_.Note) { $extra += "($($_.Note))" }
            Write-Host ("{0,-10} {1,3}  {2}:{3}  {4} {5}" -f $_.Status, $_.Code, $_.File, $_.Line, $_.Url, ($extra -join ' ')) -ForegroundColor $colour
        }
    }
    else {
        Write-Host 'All links OK.' -ForegroundColor Green
    }
}

$bad = @($rows | Where-Object { $_.Status -in 'BROKEN', 'UNGROUNDED' }).Count
exit ($(if ($bad -gt 0) { 1 } else { 0 }))
