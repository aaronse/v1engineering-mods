# tools

Small utilities for keeping the docs in this repo honest.

## check-links.ps1

Verifies every external link in a markdown/HTML file, and optionally grounds V1 Engineering shop links against a local parts library.

Needs PowerShell 7+ (uses `ForEach-Object -Parallel`).

```powershell
# problems only — the default, and what you want 95% of the time
./tools/check-links.ps1 zenxy-v3/README.md

# add offline grounding against a V1E parts library snapshot
./tools/check-links.ps1 zenxy-v3/README.md -LibraryPath E:\git\new-zenxy\models\library\v1e

# whole repo, full listing, as JSON
./tools/check-links.ps1 **/*.md -All -Json > link-report.json
```

### Why bother

A BOM is only as good as its links.  V1E is a small shop — products get renamed, merged, or quietly discontinued, and docs go stale silently.  This catches that.  First run against [zenxy-v3/README.md](../zenxy-v3/README.md) found that the threadlocker link used by the *official* LowRider 4 docs is a 404.

### What it checks

1. **Live HTTP** — `HEAD`, falling back to `GET` for servers that reject `HEAD`.
2. **Redirects** — flags when the final URL differs from what's written.  Shopify renames show up here.  URL shorteners (`amzn.to`, `a360.co`, …) are exempt since redirecting is their job.
3. **Grounding** (`-LibraryPath`) — any `v1e.com/products/<handle>` whose handle is missing from the library's `catalog.json` is flagged `UNGROUNDED`.  Pure offline check, catches links to products that never existed or no longer do.

### Statuses

| Status | Meaning |
|---|---|
| `OK` | 2xx, final URL matches (or it's a known shortener) |
| `REDIRECT` | 2xx but landed elsewhere — often a renamed/merged product |
| `BROKEN` | 404/410, other 4xx/5xx, or the request failed |
| `BLOCKED` | 401/403/429/503.  Bot-blocking and auth walls look identical to a real break over HTTP, so these **never fail the run** — check by hand |
| `UNGROUNDED` | Live check passed, but the handle isn't in the local library |

Exit code is `1` if anything is `BROKEN` or `UNGROUNDED`, else `0`.  Suitable for a pre-commit hook or CI.

### Keeping it cheap

Written to be token-efficient when you're feeding results back to an LLM:

- Default output is **one summary line per file plus one line per problem**.  Healthy links print nothing.
- Results are cached in `tools/.link-cache.json` for 24h (`-CacheHours`, `-NoCache`), so re-runs while editing don't re-hit the network.
- `-Json` for machine consumption, `-SkipPattern` to ignore known-noisy hosts.

`.link-cache.json` is throwaway — add it to `.gitignore` if it bothers you.
