/**
 * Generates the flower launcher icon PNGs.
 *
 * Design: 6-petal daisy (white → ice-blue petals, amber centre) on the
 * primary brand blue (#1B7FC4).  Mirrors assets/images/flower_logo.svg
 * so the splash logo and the launcher icon share the same visual identity.
 *
 * Outputs
 *   assets/images/app_icon.png      1024×1024  main launcher icon
 *   assets/images/app_icon_fg.png    432×432   adaptive-icon foreground layer
 *
 * Run: node tools/generate_icon.js
 */

'use strict';

const zlib = require('zlib');
const fs   = require('fs');
const path = require('path');

// ── Pure-Node PNG writer (no external deps) ─────────────────────────────────

function crc32(buf) {
  const t = [];
  for (let n = 0; n < 256; n++) {
    let c = n;
    for (let k = 0; k < 8; k++) c = (c & 1) ? 0xedb88320 ^ (c >>> 1) : c >>> 1;
    t[n] = c;
  }
  let crc = 0xffffffff;
  for (let i = 0; i < buf.length; i++) crc = t[(crc ^ buf[i]) & 0xff] ^ (crc >>> 8);
  return (crc ^ 0xffffffff) >>> 0;
}

function pngChunk(type, data) {
  const tb  = Buffer.from(type, 'ascii');
  const len = Buffer.allocUnsafe(4);
  len.writeUInt32BE(data.length, 0);
  const crcVal = Buffer.allocUnsafe(4);
  crcVal.writeUInt32BE(crc32(Buffer.concat([tb, data])), 0);
  return Buffer.concat([len, tb, data, crcVal]);
}

function writePng(W, H, pixels, outPath) {
  const sig  = Buffer.from([137, 80, 78, 71, 13, 10, 26, 10]);
  const ihdr = Buffer.allocUnsafe(13);
  ihdr.writeUInt32BE(W, 0); ihdr.writeUInt32BE(H, 4);
  ihdr[8] = 8; ihdr[9] = 2; ihdr[10] = 0; ihdr[11] = 0; ihdr[12] = 0;

  const stride = 1 + W * 3;
  const raw    = Buffer.allocUnsafe(H * stride);
  for (let y = 0; y < H; y++) {
    raw[y * stride] = 0; // filter: none
    for (let x = 0; x < W; x++) {
      const s = (y * W + x) * 3, d = y * stride + 1 + x * 3;
      raw[d] = pixels[s]; raw[d + 1] = pixels[s + 1]; raw[d + 2] = pixels[s + 2];
    }
  }

  const result = Buffer.concat([
    sig,
    pngChunk('IHDR', ihdr),
    pngChunk('IDAT', zlib.deflateSync(raw, { level: 9 })),
    pngChunk('IEND', Buffer.alloc(0)),
  ]);
  fs.writeFileSync(outPath, result);
  console.log(`  wrote ${outPath}  (${(result.length / 1024).toFixed(0)} KB)`);
}

// ── Drawing primitives ───────────────────────────────────────────────────────

/** Blend (r,g,b) onto the pixel at (px,py) with linear anti-aliased alpha. */
function blendPixel(pixels, W, px, py, r, g, b, alpha) {
  if (px < 0 || px >= W || py < 0 || py >= W) return;
  const i  = (py * W + px) * 3;
  const a  = alpha;
  const na = 1 - a;
  pixels[i]     = Math.round(pixels[i]     * na + r * a);
  pixels[i + 1] = Math.round(pixels[i + 1] * na + g * a);
  pixels[i + 2] = Math.round(pixels[i + 2] * na + b * a);
}

/**
 * Draw a filled circle with a radial gradient from centerColor to edgeColor,
 * 1-pixel anti-aliased edge, and an overall opacity multiplier.
 */
function drawCircle(pixels, W, cx, cy, radius, colorCenter, colorEdge, opacity = 1.0) {
  const [r1, g1, b1] = colorCenter;
  const [r2, g2, b2] = colorEdge;
  const x0 = Math.max(0, Math.floor(cx - radius - 1));
  const x1 = Math.min(W - 1, Math.ceil(cx + radius + 1));
  const y0 = Math.max(0, Math.floor(cy - radius - 1));
  const y1 = Math.min(W - 1, Math.ceil(cy + radius + 1));

  for (let py = y0; py <= y1; py++) {
    for (let px = x0; px <= x1; px++) {
      const dx   = px - cx, dy = py - cy;
      const dist = Math.sqrt(dx * dx + dy * dy);

      // Coverage: 1 inside, AA ramp in the outermost pixel
      let cov;
      if (dist < radius - 0.5)   cov = 1.0;
      else if (dist > radius + 0.5) continue;
      else                        cov = (radius + 0.5 - dist);

      // Radial gradient: 0 at centre → 1 at edge
      const t  = Math.min(1, dist / radius);
      const cr = Math.round(r1 + (r2 - r1) * t);
      const cg = Math.round(g1 + (g2 - g1) * t);
      const cb = Math.round(b1 + (b2 - b1) * t);

      blendPixel(pixels, W, px, py, cr, cg, cb, cov * opacity);
    }
  }
}

// ── Flower icon renderer ─────────────────────────────────────────────────────

/**
 * Renders the flower icon into a (size × size) RGB pixel buffer.
 *
 * Geometry is taken directly from flower_logo.svg (200×200 viewbox):
 *   petal dist from centre : 44
 *   petal radius           : 28
 *   centre radius          : 25
 *
 * We scale so the full flower diameter (2 × (44+28) = 144 SVG-units) maps to
 * `fillPct` of the icon's width, centred.  This lets us use the same function
 * for the main icon (generous fill) and the adaptive foreground (smaller safe zone).
 */
function renderFlower(size, fillPct = 0.72) {
  const pixels = new Uint8Array(size * size * 3);

  // Background: brand rose #C0446A
  const [bgR, bgG, bgB] = [0xC0, 0x44, 0x6A];
  for (let i = 0; i < size * size; i++) {
    pixels[i * 3] = bgR; pixels[i * 3 + 1] = bgG; pixels[i * 3 + 2] = bgB;
  }

  const cx = size / 2, cy = size / 2;

  // Scale: flower full-radius in SVG = 44 + 28 = 72 units
  // Map 72 SVG-units → (fillPct / 2) × size pixels
  const scale = (fillPct / 2 * size) / 72;

  const petalDist    = 44 * scale;
  const petalRadius  = 28 * scale;
  const centreRadius = 25 * scale;

  // ── Petal colours (white → ice-blue, matching SVG gradients) ──────────────
  const petalInner  = [255, 255, 255];      // #FFFFFF centre of petal
  const petalOuter  = [168, 212, 245];      // #A8D4F5 edge of petal

  // ── Centre colours (light amber → amber, matching SVG gradient) ────────────
  const centreInner = [255, 224, 122];      // #FFE07A
  const centreOuter = [245, 158,  11];      // #F59E0B

  // ── Draw 6 petals (0°=top, clockwise in 60° steps) ─────────────────────────
  for (let i = 0; i < 6; i++) {
    const rad = ((i * 60) - 90) * (Math.PI / 180); // −90° so 0° points up
    const px  = cx + petalDist * Math.cos(rad);
    const py  = cy + petalDist * Math.sin(rad);
    drawCircle(pixels, size, px, py, petalRadius, petalInner, petalOuter);
  }

  // ── Centre circle (on top of petals) ────────────────────────────────────────
  drawCircle(pixels, size, cx, cy, centreRadius, centreInner, centreOuter);

  // ── Highlight: semi-transparent white ellipse (approx as circle) ─────────
  //   SVG: ellipse cx=92 cy=91 rx=8 ry=6 opacity=0.40, rotate(-20)
  //   Approximated as a circle at the same relative offset from centre.
  const hlR  = 8  * scale;
  const hlCx = cx - 8 * scale;   // left of centre
  const hlCy = cy - 9 * scale;   // above centre
  drawCircle(pixels, size, hlCx, hlCy, hlR, [255, 255, 255], [255, 255, 255], 0.40);

  return pixels;
}

// ── Main ─────────────────────────────────────────────────────────────────────

const assetsDir = path.join(__dirname, '..', 'assets', 'images');

console.log('Generating flower launcher icons...');

// 1024×1024  main icon — flower at 72% of icon width
writePng(1024, 1024, renderFlower(1024, 0.72), path.join(assetsDir, 'app_icon.png'));

// 432×432  adaptive foreground — flower scaled to stay inside the Android
// safe zone (72 dp of 108 dp = 66.7%; we target 62% to add breathing room).
writePng(432, 432, renderFlower(432, 0.62), path.join(assetsDir, 'app_icon_fg.png'));

console.log('\nNext step:');
console.log('  flutter pub run flutter_launcher_icons');
