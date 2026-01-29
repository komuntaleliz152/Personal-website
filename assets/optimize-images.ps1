# Image optimization helper
# Requires ImageMagick (magick) or cwebp (from libwebp)
# Usage (from repository root):
#   powershell -ExecutionPolicy Bypass -File .\assets\optimize-images.ps1 -SourceImage 'mummy.jpg' -OutputDir '.\assets'
param(
  [string]$SourceImage = 'mummy.jpg',
  [string]$OutputDir = '.\assets'
)

if (-not (Test-Path $SourceImage)) {
  Write-Host "Source image not found: $SourceImage" -ForegroundColor Red
  exit 1
}

if (-not (Test-Path $OutputDir)) {
  New-Item -Path $OutputDir -ItemType Directory | Out-Null
}

# prefer ImageMagick
if (Get-Command magick -ErrorAction SilentlyContinue) {
  Write-Host "Using ImageMagick (magick) to create optimized images..."
  magick "$SourceImage" -strip -interlace Plane -quality 80 -resize 800x800^> "$OutputDir\mummy-800.jpg"
  magick "$OutputDir\mummy-800.jpg" "$OutputDir\mummy.webp"
  Write-Host "Generated: $OutputDir\mummy-800.jpg and $OutputDir\mummy.webp"
  exit 0
}

# fallback to cwebp
if (Get-Command cwebp -ErrorAction SilentlyContinue) {
  Write-Host "Using cwebp to create webp..."
  & cwebp -q 80 "$SourceImage" -o "$OutputDir\mummy.webp"
  Write-Host "Generated: $OutputDir\mummy.webp (install ImageMagick for resized JPEGs)"
  exit 0
}

Write-Host "No supported image optimizer found. Install ImageMagick or libwebp (cwebp) and re-run this script." -ForegroundColor Yellow
exit 1