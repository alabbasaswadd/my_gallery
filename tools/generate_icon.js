/**
 * Generates a professional, industry-neutral app icon PNG.
 * Concept: 2x2 product card grid on a professional blue background.
 * Uses only Node.js built-ins (zlib for PNG compression).
 *
 * Run: node tools/generate_icon.js
 */

const zlib = require('zlib');
const fs = require('fs');
const path = require('path');

// ---------------------------------------------------------------------------
// PNG writer (pure Node.js, no deps)
// ---------------------------------------------------------------------------

function crc32(buf) {
  const table = [];
  for (let n = 0; n < 256; n++) {
    let c = n;
    for (let k = 0; k < 8; k++) {
      c = c & 1 ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    }
    table[n] = c;
  }
  let crc = 0xffffffff;
  for (let i = 0; i < buf.length; i++) {
    crc = table[(crc ^ buf[i]) & 0xff] ^ (crc >>> 8);
  }
  return (crc ^ 0xffffffff) >>> 0;
}

function chunk(type, data) {
  const typeBytes = Buffer.from(type, 'ascii');
  const len = Buffer.allocUnsafe(4);
  len.writeUInt32BE(data.length, 0);
  const crcBuf = Buffer.concat([typeBytes, data]);
  const crc = Buffer.allocUnsafe(4);
  crc.writeUInt32BE(crc32(crcBuf), 0);
  return Buffer.concat([len, typeBytes, data, crc]);
}

function writePNG(width, height, pixels, outPath) {
  const sig = Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]);

  const ihdr = Buffer.allocUnsafe(13);
  ihdr.writeUInt32BE(width, 0);
  ihdr.writeUInt32BE(height, 4);
  ihdr[8] = 8;  // bit depth
  ihdr[9] = 2;  // color type: RGB
  ihdr[10] = 0; // compression
  ihdr[11] = 0; // filter
  ihdr[12] = 0; // interlace

  // Raw image data with filter bytes
  const raw = Buffer.allocUnsafe(height * (1 + width * 3));
  for (let y = 0; y < height; y++) {
    raw[y * (1 + width * 3)] = 0; // filter type: none
    for (let x = 0; x < width; x++) {
      const src = (y * width + x) * 3;
      const dst = y * (1 + width * 3) + 1 + x * 3;
      raw[dst] = pixels[src];
      raw[dst + 1] = pixels[src + 1];
      raw[dst + 2] = pixels[src + 2];
    }
  }

  const compressed = zlib.deflateSync(raw, { level: 9 });

  const result = Buffer.concat([
    sig,
    chunk('IHDR', ihdr),
    chunk('IDAT', compressed),
    chunk('IEND', Buffer.alloc(0)),
  ]);
  fs.writeFileSync(outPath, result);
  console.log(`Written: ${outPath} (${result.length} bytes)`);
}

// ---------------------------------------------------------------------------
// Icon drawing utilities
// ---------------------------------------------------------------------------

function setPixel(pixels, width, x, y, r, g, b) {
  if (x < 0 || x >= width || y < 0 || y >= width) return;
  const idx = (Math.round(y) * width + Math.round(x)) * 3;
  pixels[idx] = r;
  pixels[idx + 1] = g;
  pixels[idx + 2] = b;
}

function fillRect(pixels, W, x, y, w, h, r, g, b, radius = 0) {
  for (let py = Math.max(0, Math.floor(y)); py < Math.min(W, Math.ceil(y + h)); py++) {
    for (let px = Math.max(0, Math.floor(x)); px < Math.min(W, Math.ceil(x + w)); px++) {
      // Anti-aliased rounded corners
      if (radius > 0) {
        const dx = Math.max(0, Math.max(x + radius - px, px - (x + w - radius)));
        const dy = Math.max(0, Math.max(y + radius - py, py - (y + h - radius)));
        if (dx * dx + dy * dy > radius * radius) continue;
      }
      setPixel(pixels, W, px, py, r, g, b);
    }
  }
}

// ---------------------------------------------------------------------------
// Generate icon: 2×2 product card grid on blue background
// ---------------------------------------------------------------------------

function generateIcon(size) {
  const pixels = new Uint8Array(size * size * 3);

  // Background: professional blue #1B7FC4
  const [bgR, bgG, bgB] = [0x1B, 0x7F, 0xC4];
  pixels.fill(0);
  for (let i = 0; i < size * size; i++) {
    pixels[i * 3] = bgR;
    pixels[i * 3 + 1] = bgG;
    pixels[i * 3 + 2] = bgB;
  }

  // Card grid parameters
  const margin = size * 0.18;
  const gap = size * 0.06;
  const cardW = (size - margin * 2 - gap) / 2;
  const cardH = cardW * 1.1;
  const cardRadius = size * 0.045;

  // Card positions (2x2 grid centered)
  const totalH = cardH * 2 + gap;
  const startX = margin;
  const startY = (size - totalH) / 2;

  const positions = [
    [startX, startY],
    [startX + cardW + gap, startY],
    [startX, startY + cardH + gap],
    [startX + cardW + gap, startY + cardH + gap],
  ];

  // Card colors (white with slight alpha simulation)
  const [cardR, cardG, cardB] = [255, 255, 255];
  const [imgR, imgG, imgB] = [0xA8, 0xD1, 0xEC]; // light blue image placeholder
  const [lineR, lineG, lineB] = [0xD0, 0xE8, 0xF5]; // even lighter blue lines

  for (const [cx, cy] of positions) {
    // Card background
    fillRect(pixels, size, cx, cy, cardW, cardH, cardR, cardG, cardB, cardRadius);

    // Image area (top 55%)
    const imgH = cardH * 0.55;
    fillRect(pixels, size, cx, cy, cardW, imgH, imgR, imgG, imgB, cardRadius);
    // Fix bottom of image area (no radius)
    fillRect(pixels, size, cx, cy + imgH - cardRadius, cardW, cardRadius, imgR, imgG, imgB, 0);

    // Title line
    const lineH = size * 0.028;
    const lineY = cy + imgH + cardH * 0.08;
    fillRect(pixels, size, cx + cardW * 0.08, lineY, cardW * 0.72, lineH, lineR, lineG, lineB, lineH / 2);

    // Price line
    const pLineY = lineY + lineH * 1.9;
    fillRect(pixels, size, cx + cardW * 0.08, pLineY, cardW * 0.42, lineH * 0.75, lineR, lineG, lineB, lineH * 0.375);
  }

  return pixels;
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

const assetsDir = path.join(__dirname, '..', 'assets', 'images');

// Main icon: 1024x1024
const iconPixels = generateIcon(1024);
writePNG(1024, 1024, iconPixels, path.join(assetsDir, 'app_icon.png'));

// Foreground icon: 432x432 on transparent-white (PNG RGB approximation)
// For adaptive icon foreground, we center the grid on a white bg
const fgPixels = generateIcon(432);
// Replace blue background with white for the foreground layer
for (let i = 0; i < 432 * 432; i++) {
  const idx = i * 3;
  if (fgPixels[idx] === 0x1B && fgPixels[idx + 1] === 0x7F && fgPixels[idx + 2] === 0xC4) {
    fgPixels[idx] = 0xFF;
    fgPixels[idx + 1] = 0xFF;
    fgPixels[idx + 2] = 0xFF;
  }
}
writePNG(432, 432, fgPixels, path.join(assetsDir, 'app_icon_fg.png'));

console.log('\nDone! Next steps:');
console.log('  flutter pub run flutter_native_splash:create');
console.log('  flutter pub run flutter_launcher_icons');
