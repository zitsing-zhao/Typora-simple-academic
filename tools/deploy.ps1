# Copy the theme (and its asset folder, if any) into Typora's themes folder.
param([string]$Theme = "simple-academic")

$root = Split-Path $PSScriptRoot -Parent
$dest = Join-Path $env:APPDATA "Typora\themes"

Copy-Item (Join-Path $root "$Theme.css") $dest -Force
$assets = Join-Path $root $Theme
if (Test-Path $assets) { Copy-Item $assets $dest -Recurse -Force }

Write-Host "Deployed $Theme.css -> $dest"
Write-Host "In Typora: switch to another theme and back (or restart) to reload."
