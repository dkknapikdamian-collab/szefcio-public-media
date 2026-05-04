param(
  [Parameter(Mandatory=$true)][string]$ProjectId,
  [Parameter(Mandatory=$true)][string]$IssueIdentifier,
  [Parameter(Mandatory=$true)][string]$ImagePath,
  [string]$Owner="dkknapikdamian-collab",
  [string]$RepoName="szefcio-public-media",
  [int]$CleanupAfterDays=7
)

$ErrorActionPreference="Stop"

if(!(Test-Path $ImagePath)){ throw "Brak obrazu: $ImagePath" }

$RepoRoot=Split-Path -Parent $PSScriptRoot
Set-Location $RepoRoot

$sha=(Get-FileHash -Algorithm SHA256 -LiteralPath $ImagePath).Hash.ToLower()
$sha12=$sha.Substring(0,12)
$ext=[IO.Path]::GetExtension($ImagePath).ToLower()
if([string]::IsNullOrWhiteSpace($ext)){ $ext=".png" }

$yyyy=(Get-Date).ToString("yyyy")
$mm=(Get-Date).ToString("MM")

$folder=Join-Path $RepoRoot ("media\{0}\{1}\{2}" -f $ProjectId,$yyyy,$mm)
New-Item -ItemType Directory -Force -Path $folder | Out-Null

$fileName=("{0}_{1}{2}" -f $IssueIdentifier,$sha12,$ext)
$target=Join-Path $folder $fileName
Copy-Item -Force -LiteralPath $ImagePath -Destination $target

$relative=("media/{0}/{1}/{2}/{3}" -f $ProjectId,$yyyy,$mm,$fileName)
$rawUrl=("https://raw.githubusercontent.com/{0}/{1}/main/{2}" -f $Owner,$RepoName,$relative)
$createdAt=(Get-Date).ToUniversalTime().ToString("o")
$cleanupAfter=(Get-Date).ToUniversalTime().AddDays($CleanupAfterDays).ToString("o")

$ledger=Join-Path $RepoRoot "manifests\public_media_ledger.csv"
if(!(Test-Path $ledger)){
  "createdAt,projectId,issueIdentifier,sha256,fileName,relativePath,rawUrl,status,cleanupAfter,publishedAt,deletedAt" | Set-Content -Encoding UTF8 $ledger
}

Add-Content -Encoding UTF8 $ledger "$createdAt,$ProjectId,$IssueIdentifier,$sha,$fileName,$relative,$rawUrl,uploaded_candidate,$cleanupAfter,,"

git add -A
git commit -m "Add public media $ProjectId $IssueIdentifier $sha12"
git push -u origin main

Write-Host ""
Write-Host "PUBLIC_MEDIA_URL:"
Write-Host $rawUrl
Write-Host ""
Write-Host "LOCAL_TARGET:"
Write-Host $target
Write-Host ""
Write-Host "SHA256:"
Write-Host $sha
