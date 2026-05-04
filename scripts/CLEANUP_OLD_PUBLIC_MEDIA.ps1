param(
  [int]$OlderThanDays=7
)

$ErrorActionPreference="Stop"

$RepoRoot=Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

$cutoff=(Get-Date).ToUniversalTime().AddDays(-1 * $OlderThanDays)
$deleted=0

Get-ChildItem "$RepoRoot\media" -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
  if($_.LastWriteTimeUtc -lt $cutoff){
    git rm -f -- $_.FullName | Out-Null
    $deleted++
  }
}

if($deleted -gt 0){
  git commit -m "Cleanup old public media"
  git push
}

Write-Host "Deleted old media files:" $deleted
