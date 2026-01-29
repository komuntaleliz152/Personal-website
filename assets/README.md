Image optimization helpers

This folder contains a simple PowerShell script to create optimized variants of `mummy.jpg`.

How to use

1. Ensure you have either ImageMagick (`magick`) or `cwebp` installed and available on PATH.
2. From the repo root run:

   ```powershell
   powershell -ExecutionPolicy Bypass -File .\assets\optimize-images.ps1 -SourceImage 'mummy.jpg' -OutputDir '.\assets'
   ```

What it generates

- `assets/mummy-800.jpg` — resized and compressed JPEG (if ImageMagick is available)
- `assets/mummy.webp` — WebP version (if ImageMagick or cwebp is available)

Notes

- The `index.html` hero now uses a `picture` element that prefers `assets/mummy.webp` with fallbacks to `assets/mummy-800.jpg` and the original `mummy.jpg`.
- If you want me to compress the image for you, I can do it here, but I need ImageMagick or similar tooling available in this environment. Alternatively, upload the image and I can optimize it locally.