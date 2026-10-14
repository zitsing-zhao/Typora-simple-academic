# Render preview.html (or -Page) to shots\<Out> with headless Edge.
param([int]$Width = 1100, [int]$Height = 2600, [string]$Out = "preview.png", [string]$Page = "preview.html")

$root = Split-Path $PSScriptRoot -Parent
$edge = "${env:ProgramFiles(x86)}\Microsoft\Edge\Application\msedge.exe"
$shots = Join-Path $root "shots"
New-Item -ItemType Directory -Force $shots | Out-Null

$html = "file:///" + ((Join-Path $root $Page) -replace '\\', '/')
$png = Join-Path $shots $Out

& $edge --headless=new --disable-gpu --hide-scrollbars `
  "--window-size=$Width,$Height" "--screenshot=$png" $html 2>$null | Out-Null
Start-Sleep -Milliseconds 300
if (Test-Path $png) { Write-Host "Saved $png" } else { Write-Error "Screenshot failed" }
