param (
    [string]$Path = ".",
    [switch]$Recurse
)

if (-Not (Test-Path $Path -PathType Container)) {
    Write-Host "Error: The specified path does not exist or is not a directory."
    exit
}

$files = Get-ChildItem -Path $Path -File -Recurse:$Recurse | Group-Object Extension | Sort-Object Count -Descending

Write-Host "File count by type in '$Path':"
$files | ForEach-Object { Write-Host "$($_.Name): $($_.Count)" }
