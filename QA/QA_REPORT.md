# QA_REPORT.md — Bugs & Issues

Backend = source of truth (`D:\MyGallery project`). Frontend = `D:\المعرض\my_gallery`.
Verification is **static** (code audit). Live user-flow execution (STEP 5/6) was **not possible in this environment**: the Flutter app needs Flutter ~3.44.9 (installed 3.38.4), and the API needs SQL Server + an injected `Jwt:SigningKey`; the app points at a hosted API (`alqaleatalsaghira-api.codetechsyria.com`) with unknown credentials. Backend **compiles cleanly** (`dotnet build` → 0 warnings/0 errors on .NET 10).

Severity: **Critical** (blocks a core flow / data loss) · **High** · **Medium** · **Low**.

---

## #1 — Product creation is impossible (no category picker)
- **Severity:** Critical
- **Module:** Products (Frontend)
- **Description:** The product form has no control to choose a category, but the backend requires `CategoryId > 0`.
- **User Flow:** Products → "+" → fill name/price → Save.
- **Steps:** Open `/products/create`; there is no category field; tapping Save.
- **Expected:** Able to pick a category and create the product (201).
- **Actual:** `_categoryId` is null; submit aborts with a snackbar ("choose category") that cannot be satisfied. No product is ever created.
- **Root Cause:** `_categoryId` is only set from `existing?.categoryId`; no UI sets it on create.
- **Suggested Fix:** Add a required category `DropdownButtonFormField` fed by `CategoriesCubit`/`getCategories()`; bind to `_categoryId`; validate before submit.
- **Frontend Files:** `lib/features/products/presentation/screens/product_form_screen.dart` (`_categoryId` L29/L55/L73/L81).
- **Backend Files:** `MyGallery.Api/Controllers/V1/ProductsController.cs`, `Application/Features/Catalog/…/CreateProductValidator`.
- **API:** `POST /api/v1/products` (needs `categoryId`).

## #2 — Category edit opens blank → silent overwrite / data loss
- **Severity:** Critical
- **Module:** Categories (Frontend)
- **Description:** Editing a category navigates without passing the existing entity and never fetches it, so the form initializes empty. Saving then overwrites the real category with blank values.
- **User Flow:** Categories → ⋮ → Edit → Save.
- **Steps:** `categories_screen.dart:99` calls `context.push('/categories/${cat.id}/edit')` with **no `extra`**; route reads `state.extra as CategoryDetail?` → null; `getCategory(id)` never called.
- **Expected:** Form pre-filled with the category's name/description/order/active.
- **Actual:** Empty form; a save issues `PUT` with blank name (or fails validation) — at best confusing, at worst wipes fields.
- **Root Cause:** Missing detail fetch; also the list item is a `CategoryListItem`, not the `CategoryDetail` the route expects.
- **Suggested Fix:** Load via `getCategory(id)` (already in service) before showing the form, or pass and adapt the data; pre-populate controllers.
- **Frontend Files:** `categories_screen.dart` (L99-100), `category_form_screen.dart`, `categories_service.dart` (`getCategory`).
- **API:** `GET /api/v1/categories/{id}`.

## #3 — Uploaded images may not load (API host serves no static files)
- **Severity:** High
- **Module:** Images / Infrastructure (Backend/Deployment)
- **Description:** `MyGallery.Api` has **no `UseStaticFiles`**; it stores images under `wwwroot/uploads` and returns `/uploads/...` URLs, but does not serve them. The Flutter app resolves image URLs as `AppConfig.baseUrl + /uploads/...` (the API host).
- **Expected:** Product/logo/favicon/hero images load in the app.
- **Actual (as committed):** Image URLs against the API host would 404 unless a reverse proxy or the MVC host serves `/uploads`.
- **Root Cause:** Static file middleware only exists in the MVC host, not the API.
- **Suggested Fix:** Add `UseStaticFiles` (mapping `/uploads`) to `MyGallery.Api`, or serve uploads via CDN/blob and return absolute URLs, or document the proxy rule. **Verify against the live host.**
- **Backend Files:** `MyGallery.Api/Program.cs`, `Infrastructure/.../LocalImageStorage.cs`.
- **Frontend Files:** image URL resolution (e.g. `site_customization_screen.dart` `_resolveImageUrl`, product/storefront image widgets).

## #4 — Validation errors (RFC-7807) not surfaced to the user
- **Severity:** Medium
- **Module:** Networking / Error handling (Frontend)
- **Description:** DataAnnotation failures (e.g. missing `Name`, bad `StockQuantity`) return `application/problem+json` (`title`, `errors` as a **dictionary**), not the `ApiResponse` envelope. `ApiException.fromDio` reads `data['message']` and expects `errors` as a **List**, so it finds neither.
- **Expected:** Field-level Arabic messages shown.
- **Actual:** Generic "بيانات غير صالحة" for all 400/422 model-binding errors; field details lost.
- **Root Cause:** Frontend only parses the envelope shape, not problem+json.
- **Suggested Fix:** In `ApiException.fromDio`, detect problem+json (`title` + `errors` map) and flatten the map into messages.
- **Frontend Files:** `lib/core/network/api_exception.dart`.
- **Backend Files:** `MyGallery.Api/DependencyInjection/ApiServiceExtensions.cs` (`InvalidModelStateResponseFactory`).

## #5 — Category actions not role-gated for Employee
- **Severity:** Medium
- **Module:** Categories / Permissions (Frontend)
- **Description:** Category create/update/delete/reorder/activate require **OwnerOrManager** on the backend, but the Categories tab exposes edit/delete/reorder/toggle to any authenticated user (Employee included). Employee actions return 403.
- **Expected:** Employees see read-only categories (no edit/delete/reorder/toggle).
- **Actual:** Buttons visible; tapping → 403 error snackbar.
- **Root Cause:** UI gating only applied to the "+" add button, not the row actions.
- **Suggested Fix:** Gate row actions and the reorder handle on `role == Owner || Manager` (mirror the add button).
- **Frontend Files:** `categories_screen.dart`.
- **Backend Files:** `CategoriesController.cs` (policies).

## #6 — Product image add/delete/set-cover unreachable on the detail screen
- **Severity:** Medium
- **Module:** Products (Frontend)
- **Description:** `ProductDetailCubit.uploadImages/deleteImage/setCover` exist but have no buttons on the detail screen (only "replace" is wired). Full image management requires going through the edit form. `PATCH /cover-image` is never hit at runtime.
- **Expected:** Add/remove/set-cover reachable from product detail.
- **Actual:** Only replace-in-place; other flows only via form.
- **Suggested Fix:** Add image-management actions to `product_detail_screen.dart`.
- **Frontend Files:** `product_detail_screen.dart`, `product_detail_cubit.dart`.

## #7 — Order status transitions unvalidated (any → any)
- **Severity:** Medium
- **Module:** Orders (Backend + Frontend)
- **Description:** `UpdateOrderStatusHandler` sets whatever status is supplied — no workflow rules (e.g. `Completed → New`, `Cancelled → Confirmed` all allowed). The app likewise offers all statuses unconditionally.
- **Expected:** Enforced/relevant transitions (or at least a guarded state machine).
- **Actual:** Any status can move to any status.
- **Suggested Fix:** Define allowed transitions server-side (authoritative) and reflect them in the app's ChoiceChips.
- **Backend Files:** `Application/Features/Orders/…/UpdateOrderStatusHandler`.
- **Frontend Files:** `order_detail_screen.dart`.

## #8 — Product price parsing can throw on non-numeric input
- **Severity:** Medium
- **Module:** Products (Frontend)
- **Description:** The form validates price as non-empty but then uses `double.parse`; a non-numeric string passes the "required" check and throws `FormatException` on submit.
- **Suggested Fix:** Use `double.tryParse` with a validator that rejects non-numeric/negative values.
- **Frontend Files:** `product_form_screen.dart`.

## #9 — Storefront product detail surfaces raw exception text
- **Severity:** Low
- **Module:** Storefront (Frontend)
- **Description:** `StorefrontProductDetailScreen` handles "add to cart" errors via local `setState` using `e.toString()` rather than `ApiException.message`, showing raw exception text.
- **Suggested Fix:** Map through `ApiException` and show `.message`.
- **Frontend Files:** `storefront_product_detail_screen.dart`.

## #10 — Dead code: `splash_screen.dart` references a non-existent route
- **Severity:** Low
- **Module:** Auth (Frontend)
- **Description:** `splash_screen.dart` is never routed and navigates to `/login`, which is not registered (login is `/`).
- **Suggested Fix:** Delete the file or wire it and fix the route.
- **Frontend Files:** `lib/features/auth/presentation/screens/splash_screen.dart`.

## #11 — Startup swallow in `checkSession`
- **Severity:** Low
- **Module:** Auth (Frontend)
- **Description:** `auth_cubit.dart` `checkSession` `catch (_)` → silently `unauthenticated`, masking network/parse errors at launch (a transient failure logs the user out).
- **Suggested Fix:** Distinguish "no session" from "network error" (keep session on transient error, surface a retry).
- **Frontend Files:** `auth_cubit.dart`.

---

## Backend security & configuration findings
(Backend is the source of truth; these are recorded for completeness. Priorities are for the platform, not the app.)

## #S1 — `Jwt:SigningKey` empty in `appsettings.json`
- **Severity:** High (config) — API **fails to start in Production** unless the key is injected (env/user-secrets). Only Development supplies a key.
- **Files:** `MyGallery.Api/appsettings.json`, `AddJwtAuthentication`.

## #S2 — Production connection string with password committed to source
- **Severity:** High (security). Rotate the password; move to user-secrets/env.
- **Files:** `MyGallery.Api/appsettings.json`.

## #S3 — CORS wide-open by default
- **Severity:** Medium. Empty `Cors:AllowedOrigins` falls back to `AllowAnyOrigin/AnyHeader/AnyMethod`.
- **Files:** `MyGallery.Api` CORS setup.

## #S4 — Swagger enabled in all environments (incl. Production)
- **Severity:** Medium. Gate Swagger to non-Production.
- **Files:** `MyGallery.Api/Program.cs`.

## #S5 — Image validation by Content-Type only; no request-body size cap
- **Severity:** Medium. `UploadRules` checks MIME (spoofable) + 5 MB app-level; no `MultipartBodyLengthLimit`/magic-byte/extension check. Note `image/jpg` is not in the allow-list (only `image/jpeg`).
- **Files:** `MyGallery.Api/.../UploadRules.cs`, `LocalImageStorage.cs`.

## #S6 — Permission claims are informational, not enforced
- **Severity:** Low (by design, but note). Guards are role policies (`OwnerOnly`/`OwnerOrManager`/`AnyStaff`); the `permission[]` claims (e.g. `products.write`, `users.manage`) are never checked. Product create/update require only `AnyStaff`.
- **Files:** `ApiPolicies.cs`, `RolePermissions.cs`, controllers.

## #S7 — Hardcoded demo passwords in source (Dev-only)
- **Severity:** Low. `IdentitySeed.cs` seeds `Owner@123`/`Manager@123`/`Employee@123` (Development only).

## #S8 — Two parallel migration folders
- **Severity:** Low (maintenance hazard). `Persistence/Migrations/` vs `Migrations/` with divergent namespaces.

---

## Documentation vs implementation divergences (STEP 1)
- `PROJECT_ARCHITECTURE.md` describes an **MVC-only, .NET 10, CQRS-planned, demo-content, cookie-auth** solution and **never mentions `MyGallery.Api`, JWT, API versioning, or the V1 controllers**. Reality: a full JSON REST API with implemented CQRS-style handlers, FluentValidation, DB-backed storefront, and JWT.
- Analytics/Engagement docs claim "no migrations / no controllers / no UI" — **false** (migration `…addNewComponenet` creates tables; `AnalyticsController`, `CommentsController`, `EngagementController`, `TrackController` exist in the MVC host).
- Refresh tokens were added then removed (`RemoveRefreshTokens`); current state is access-token-only (matches the app).
- Seed locale inconsistency: primary seeder = Saudi (+966) shop; Dev-only seeder = Syrian (+963) shop + demo users.
- Frontend `CLAUDE.md` omits `PATCH /settings/social` details vs the richer server contract (minor).
