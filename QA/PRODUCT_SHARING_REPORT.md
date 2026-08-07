# PRODUCT_SHARING_REPORT.md

Product Details redesign + Sharing + QR (product & store) + Home refresh + caching.
Branch **`feature/qa-implementation`** (frontend repo `D:\المعرض\my_gallery`).

> ⚠️ **Verification status:** implemented and **committed & pushed** per explicit user
> decision, but **not locally verified** — the installed toolchain (Flutter 3.38.4 /
> Dart 3.10.3) is older than the project's pinned Dart `^3.12.2` (Flutter 3.44.9), so
> `build_runner` / `flutter analyze` / `flutter test` cannot run here. All **new** files
> were written to compile cleanly and use no codegen. See `QA/PUSH_BLOCKERS.md`.

---

## 1. Scope delivered

| # | Feature | Status |
|---|---|---|
| 1 | Product Details redesign (Material 3) | ✅ |
| 2 | Product sharing — copy link / share link / open in browser | ✅ |
| 3 | Product QR — generate / preview / save PNG / share image / copy URL | ✅ |
| 4 | Store QR — preview / save / share / copy website URL | ✅ |
| 5 | Home refresh button + pull-to-refresh (products, categories, settings→hero/store info/cache) | ✅ |
| 6 | Share menu (modern bottom sheet inside Product Details) | ✅ |
| 7 | Backend support review (slug / public URL / store URL) | ✅ (no change needed) |
| 8 | Local cache (logo / website / store info, served instantly then refreshed) | ✅ (already provided by `SettingsCubit`; refresh re-caches) |
| 9 | UI states — loading skeleton / empty / error / image loading / animations | ✅ |

---

## 2. Backend changes

**None required.** The .NET backend (separate repo `D:\MyGallery project`) already exposes
everything the feature needs, so backward compatibility is fully preserved:

- **Store URL** — `settings.website` (`GET /settings`, `GET /storefront/{shopId}/settings`) already present.
- **Public product URL** — built client-side as `{website}/product/{id}`. Products have **no slug**
  in the contract; per the requirement ("prefer slug if supported, otherwise use id") we use the
  numeric product `id`. The path segment is a single constant (`StoreLinks.productPathSegment`) so it
  can be re-pointed if the website ever adopts slugs.
- No DTO changes, no migration.

> If product slugs are desired later, add a `slug` to the product entity/DTO + a migration and
> switch `StoreLinks.productUrl` to prefer it — the client is already structured for that swap.

---

## 3. Frontend changes

### New files
| File | Purpose |
|---|---|
| `lib/core/utils/store_links.dart` | `StoreLinks` — normalises `settings.website` and builds `storeUrl` / `productUrl(id)` / `pretty(url)`. Returns `null` when no website is set (UI degrades gracefully). |
| `lib/shared/services/share_service.dart` | `ShareService` — `copyText`, `shareText`, `openUrl`, `shareImage(bytes)`, `saveImageToGallery(bytes)` (via `gal`), with consistent Arabic SnackBar feedback. |
| `lib/shared/widgets/qr_card.dart` | Printable QR card (store logo, store name, product name, QR, small URL). Fixed **light** palette for high-contrast, scannable exports regardless of app theme. |
| `lib/shared/widgets/qr_export_screen.dart` | Full-screen QR preview; `RepaintBoundary` → PNG capture; Save / Share image / Copy / Open actions. Precaches the logo before capture. Shared by product & store QR. |
| `lib/features/products/presentation/widgets/product_share_sheet.dart` | Modern share bottom sheet: Copy link, Share link, رمز QR, Open in browser; graceful "no website set" notice with a shortcut to appearance settings. |

### Edited files
| File | Change |
|---|---|
| `lib/features/products/presentation/screens/product_detail_screen.dart` | **Full M3 redesign** — rounded image gallery with counter + cover badge + per-image menu, header card (status chips, title, price + strikethrough + discount %, stock-availability pill), quick-actions card, product-information card, category + occasions card (resolves category name + occasion names), description card, owner delete. Skeleton **loading** state, error+retry, staggered entrance animations, RTL-safe (`PositionedDirectional`). AppBar gains **Share** + Edit. |
| `lib/features/products/presentation/screens/products_screen.dart` | AppBar **Refresh** button + pull-to-refresh both call `_refreshAll` → products + categories + settings (hero slider, store info, settings) with cache re-write and a confirmation SnackBar. |
| `lib/features/profile/presentation/screens/profile_screen.dart` | New **"رمز QR للمتجر"** entry → `QrExportScreen` for the store website. |
| `lib/features/storefront/presentation/screens/storefront_product_detail_screen.dart` | AppBar **Share** action (public product page is shareable too). |
| `pubspec.yaml` | Added `share_plus`, `qr_flutter`, `path_provider`, `gal`. Lowered SDK floor to `>=3.10.0 <4.0.0` (backward compatible — a newer SDK still satisfies it; required to resolve on the only installed SDK). |
| `android/app/src/main/AndroidManifest.xml` | `WRITE_EXTERNAL_STORAGE` (`maxSdkVersion=29`) for gallery save on legacy Android; `VIEW`/`BROWSABLE` `https` query for `url_launcher`. |
| `ios/Runner/Info.plist` | `NSPhotoLibraryAddUsageDescription` (Arabic) for saving QR PNGs. |

---

## 4. API changes

None. All actions reuse existing endpoints and the existing `settings.website` field.

---

## 5. QR features

- **Product QR** — `{website}/product/{id}`; card shows store logo + name + product name + QR + URL caption.
- **Store QR** — `{website}`; same card without a product name.
- **Content is only the URL** (nothing else encoded), as specified.
- Export: **Save PNG to gallery** (`gal`, album "MyGallery"), **Share image** (`share_plus`), **Copy URL**, **Open**.
- Capture via `RepaintBoundary.toImage(pixelRatio: 3.0)` → PNG bytes (no server round-trip). Logo is precached first so it always renders in the exported image.

---

## 6. Sharing features

- **Copy Link** — `Clipboard` + confirmation.
- **Share Link** — native share sheet (`SharePlus.instance.share`).
- **Open in Browser** — `url_launcher` external application.
- Entry points: Product Details AppBar (admin), Storefront product AppBar (public), and the share bottom sheet.

---

## 7. Local cache

`SettingsCubit` already implements the required pattern: it serves the cached
`StorefrontSettings` (brand name, logo, website, store info, hero slides) from
`shared_preferences` **instantly**, then refreshes from the server and re-caches. The new
Home **Refresh** re-invokes `SettingsCubit.load(shopId)`, which rewrites the cache — so
changed settings update the cache automatically. No new cache layer was needed.

---

## 8. Files changed (summary)

Added: 5 Dart files + this report + `PUSH_BLOCKERS.md` update.
Edited: 4 screens, `pubspec.yaml`, `AndroidManifest.xml`, `Info.plist`, `QA/IMPLEMENTATION_SUMMARY.md`.

---

## 9. Testing results

- **`dart format`** — applied to all new/edited Dart files (clean).
- **`flutter analyze` / `flutter test` / `flutter build`** — **could not run** in this environment
  (SDK gap above). New files were authored to be analyzer-clean and use no `build_runner` codegen;
  the pre-existing analyzer errors in the repo come from missing generated `*.freezed.dart`/`*.g.dart`
  (e.g. the occasions feature) that only regenerate on Flutter 3.44.9.

### Reviewer checklist (run on Flutter ~3.44.9)
```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
dart format . && flutter analyze && flutter test
flutter run --dart-define=SHOP_ID=2
```
- [ ] Product detail renders (gallery, price/discount %, stock pill, info, category+occasions, description), RTL + light/dark.
- [ ] Share sheet: Copy link, Share link, Open in browser.
- [ ] Product QR: preview → Save PNG (appears in gallery), Share image, Copy URL.
- [ ] Profile → Store QR: preview → Save / Share / Copy.
- [ ] Home: Refresh button + pull-to-refresh update products/categories/settings.
- [ ] No-website case: share/QR show the graceful "add website" notice.
