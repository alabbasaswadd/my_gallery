# IMPLEMENTATION_SUMMARY.md

Implementation of the QA backlog (`QA/QA_REPORT.md`, `MISSING_FEATURES.md`, etc.).
All work is on **local branch `feature/qa-implementation`** in both repos. **Nothing pushed / merged / PR'd.**

- Backend repo: `D:\MyGallery project` — branch `feature/qa-implementation` (4 commits).
- Frontend repo: `D:\المعرض\my_gallery` — branch `feature/qa-implementation` (5 commits).

## ⚠️ Verification status (read first)
- **Backend**: every change was verified with `dotnet build` (.NET 10) → **0 warnings / 0 errors**.
- **Frontend**: **could not be built/analyzed/run in this environment** — installed Flutter is 3.38.4 but the
  project requires ~3.44.9 (Dart `^3.12.2`). Frontend code was written to the project's existing
  architecture and conventions and **reuses existing models (no new `@freezed` types → no `build_runner`
  needed)**, but it still must be verified by the developer:
  ```
  flutter pub get
  flutter analyze          # must be clean
  flutter run --dart-define=SHOP_ID=2   # exercise the flows below
  ```
- Running the API locally additionally needs SQL Server + an injected `Jwt:SigningKey` (see Known Limitations).

---

## Implemented — Fixed bugs

| ID | Severity | Area | What changed | Commit / files |
|---|---|---|---|---|
| **#1** | Critical | Products (app) | Added a **category picker** (dropdown fed by `CategoriesCubit`, with loading/error/retry + required validation) to the product form; product creation is now possible. Provided `CategoriesCubit` to the product form routes. | `product_form_screen.dart`, `routes.dart` |
| **#8** | Medium | Products (app) | Price now validated as numeric `> 0` (`tryParse`) instead of `double.parse` that could throw. | `product_form_screen.dart` |
| **#2** | Critical | Categories (app) | Category **edit loads the existing category** via `CategoryFormCubit.loadDetail` (loading/error/retry); `parentId` is preserved on update (no more blank overwrite / tree re-rooting). | `category_form_cubit.dart`, `category_form_screen.dart`, `routes.dart` |
| **#3** | High | Images (api) | Added `app.UseStaticFiles()` so the `/uploads/...` URLs the API returns are actually served. | `MyGallery.Api/Program.cs` |
| **#4** | Medium | Networking (app) | `ApiException.fromDio` now parses **RFC-7807 problem+json** (`title` + field-error map) and flattens field messages, so model-binding validation errors are shown instead of a generic message. | `api_exception.dart` |
| **#6** | Medium | Products (app) | Product **detail screen** now exposes full image management (add images, per-image set-cover / replace / delete) wired to the existing `ProductDetailCubit` methods. | `product_detail_screen.dart` |
| **#9** | Low | Storefront (app) | Storefront product detail maps errors through `ApiException.message` instead of raw `e.toString()`. | `storefront_product_detail_screen.dart` |
| **#10** | Low | Auth (app) | Removed dead `splash_screen.dart` (unrouted, referenced non-existent `/login`). | deleted |
| **#5** | — | Categories (app) | **No change needed** — `categories_screen.dart` already gates toggle/edit/delete/reorder behind `_canManage` (Owner/Manager). The QA finding overstated this. | (verified) |
| **#S4** | Medium | Security (api) | Swagger UI is served **outside Production by default**; a `Swagger:Enabled` flag can force-enable it. | `Program.cs` |
| **#S5** | Medium | Security (api) | Upload validation adds an **extension allow-list** (defense-in-depth vs spoofed Content-Type) and accepts `image/jpg`. | `Common/UploadRules.cs` |

## Implemented — New features

| ID | Area | What changed | Files |
|---|---|---|---|
| **A8** | Products (app) | **Category filter** in the products filter sheet (chips fed by `CategoriesCubit`). Filter is now built explicitly instead of `copyWith`, so cleared fields (category / price) actually reset — also fixes a latent price-clear bug. | `products_filter_sheet.dart`, `products_screen.dart` |
| **A9** | Storefront (app) | **Hero slides carousel** rendered at the top of the storefront from `SettingsCubit` (image + title/subtitle + CTA), skipping empty-image slides. | `storefront_screen.dart` |

## Files changed
**Backend (`MyGallery.Api`):** `Program.cs`, `Common/UploadRules.cs`.
**Frontend (`lib/`):** `routes.dart`, `core/network/api_exception.dart`,
`features/categories/domain/category_form_cubit.dart`,
`features/categories/presentation/screens/category_form_screen.dart`,
`features/products/presentation/screens/product_form_screen.dart`,
`features/products/presentation/screens/product_detail_screen.dart`,
`features/products/presentation/screens/products_screen.dart`,
`features/products/presentation/widgets/products_filter_sheet.dart`,
`features/storefront/presentation/screens/storefront_screen.dart`,
`features/storefront/presentation/screens/storefront_product_detail_screen.dart`,
(deleted) `features/auth/presentation/screens/splash_screen.dart`.

---

## Not implemented — with reasons

### Blocked on NEW backend endpoints (the API does not expose these; a Flutter screen alone cannot integrate them)
These require adding controllers/handlers/DTOs/validators (and in some cases migrations) to `MyGallery.Api`
**first**, then a Flutter module. Each is a full-stack feature, not a small fix.

| ID | Feature | Why blocked |
|---|---|---|
| A5 | Category image upload | No category-image upload endpoint exists in the API (only product-image and settings-image endpoints). Needs a backend endpoint. |
| A6 / B6 | Product tags & occasions association; occasion/tag lists | No `GET occasions` / `GET tags` (or CRUD) endpoints. Product write accepts `tagIds`/`occasionIds` but there is no way to enumerate them. |
| B1 | Favorites / wishlist | No favorites API (web used localStorage). |
| B2 | Analytics / view tracking | Analytics features live only in the MVC host (`/track/*`); no JSON API. |
| B3 | Comments / reviews | Engagement lives only in the MVC host; no JSON API. |
| B4 | Reactions / likes | Engagement lives only in the MVC host; no JSON API. |
| B5 | Gallery albums | Gallery has no controller in `MyGallery.Api`. |
| B7 | User / staff management | `User` entity + `users.manage` permission exist but there is **no** user-management endpoint. |

### Deferred (feasible but not done this pass)
| ID | Feature | Reason / note |
|---|---|---|
| A4 | Category parent (sub-category) picker | Data-loss risk already removed (#2 preserves `parentId`). Adding the picker is a self-contained follow-up (parent dropdown in the category form, excluding self). Deferred to limit unverified UI churn. |
| A7 | Product extra fields (barcode/weight/dimensions) inputs | Low priority; model already supports them; form inputs deferred. |
| #7 | Order status **workflow** rules | Backend + app change that must be designed together (server-authoritative transition table + app chip gating). Both currently allow any→any. Deferred as a coordinated change. |
| #11 | `checkSession` resilience | Minor: distinguish "no session" from a transient network error at startup. Deferred. |

### Backend config / ops (not code fixes, or risky to change blindly)
| ID | Item | Recommendation |
|---|---|---|
| #S1 | `Jwt:SigningKey` empty in `appsettings.json` | Inject via env var / user-secrets in Production (API throws on startup without a ≥32-char key). Not committed as a hardcoded secret. |
| #S2 | Committed production connection string w/ password | Move to user-secrets/env and **rotate** the password. |
| #S3 | Wide-open CORS default | Set `Cors:AllowedOrigins` to the real client origins in Production. |
| #S6 | Permission claims not enforced (role policies only) | Acceptable by design; consider claim-based policies if finer control is needed. |
| #S7 | Hardcoded demo passwords (Dev-only seed) | Fine for Development; ensure Dev-only. |
| #S8 | Two migration folders | Consolidate `Persistence/Migrations` vs `Migrations` to avoid drift. |

---

## Remaining issues (open)
- All **Blocked** and **Deferred** items above.
- Documentation drift: `PROJECT_ARCHITECTURE.md` still doesn't describe `MyGallery.Api` (JWT/versioning/controllers) — doc update recommended.

## Known limitations of this implementation pass
1. **Frontend not statically analyzed or run** here (SDK mismatch). Run `flutter analyze` + the app before relying on the UI changes.
2. **API not run** here (needs SQL Server + injected `Jwt:SigningKey`); only `dotnet build` was verified.
3. The app targets a **hosted** API (`alqaleatalsaghira-api.codetechsyria.com`); end-to-end behavior depends on that deployment (esp. that `/uploads` is served — the #3 fix applies to the API host; confirm the deployed host includes it or proxies uploads).

## Recommendations (next steps, in order)
1. Developer runs `flutter pub get && flutter analyze && flutter run` and exercises: login → products (create with category, filter by category, detail image add/replace/cover/delete, activate/stock/price/discount/duplicate) → categories (create/edit/reorder/activate/delete) → settings (site customization save + live theme) → storefront (hero, browse, cart, checkout).
2. Deploy the API with `UseStaticFiles` (#3) and a real `Jwt:SigningKey` (#S1); restrict CORS (#S3); rotate the DB secret (#S2).
3. Backend endpoints for the **Blocked** features (occasions/tags first — they unblock A6/A8-by-occasion; then favorites, gallery, users, engagement/analytics), each followed by its Flutter module.
4. Implement the **Deferred** items (A4 parent picker, A7 fields, #7 order workflow, #11).

## Verification checklist for the reviewer
- [ ] `dotnet build "MyGallery project/MyGallery.Api"` → clean (confirmed here).
- [ ] `flutter pub get` → `flutter analyze` → clean.
- [ ] Product **create** works (category required + selectable).
- [ ] Category **edit** pre-fills and preserves parent.
- [ ] Uploaded images load (API serves `/uploads`).
- [ ] Validation errors show field messages (RFC-7807).
- [ ] Product detail add/replace/cover/delete image works.
- [ ] Products filter by category works and clears.
- [ ] Storefront shows hero slides.
