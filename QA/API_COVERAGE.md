# API_COVERAGE.md — Backend Endpoints vs Flutter Integration

**Backend (source of truth):** `D:\MyGallery project` — .NET 10 REST API, `MyGallery.Api/Controllers/V1/*`.
**Frontend:** `D:\المعرض\my_gallery` — Flutter (Dio). Base URL = `AppConfig.baseUrl + /api/v1`; service paths are relative (e.g. `/products` → `/api/v1/products`).

> **Implementation update (branch `feature/qa-implementation`)** — see `IMPLEMENTATION_SUMMARY.md`.
> #4 `GET /products` category filter now wired (UI chips). #6/#18 product-image add/delete/**cover** now
> reachable from the detail screen. #6 create flow (#6→endpoint POST /products) unblocked via category
> picker. #22 category update no longer blank. Image `/uploads` now served by the API (#3).

**Total backend endpoints: 38** across 6 controllers. **Service-level integration: 38/38** (every endpoint is referenced by a Dio service method). Gaps are at the **UI level** (integrated but unreachable) and in **query-parameter coverage**.

Legend — **Used by Flutter**: `YES` (integrated + reachable), `PARTIAL` (integrated but unreachable, or only some params used), `NO` (no service call).

| # | Method + Route | Auth (backend) | Flutter service method | Used | Notes / Missing UI |
|---|---|---|---|---|---|
| 1 | `POST /auth/login` | Anonymous | `AuthService.login` | YES | — |
| 2 | `POST /auth/logout` | Authenticated | `AuthService.logout` | YES | Network error swallowed (intentional). |
| 3 | `GET /auth/me` | Authenticated | `AuthService.getMe` | YES | — |
| 4 | `GET /products` | AnyStaff | `ProductsService.getProducts` | PARTIAL | Uses Search/Sort/MinPrice/MaxPrice/IsActive/Page/PageSize. **No UI for `CategoryId` filter** (supported by service+cubit, no control in filter sheet). `OccasionId`/`TagId` not supported at all. |
| 5 | `GET /products/{id}` | AnyStaff | `ProductsService.getProduct` | YES | — |
| 6 | `POST /products` | AnyStaff | `ProductsService.createProduct` | PARTIAL | Integrated, but **create flow is broken** — product form has no category picker and `CategoryId` is required (see QA_REPORT #1). |
| 7 | `PUT /products/{id}` | AnyStaff | `ProductsService.updateProduct` | YES | Edit works, but category cannot be changed (no picker). Sends `tagIds`/`occasionIds` that the UI never populates. |
| 8 | `DELETE /products/{id}` | **OwnerOnly** | `ProductsService.deleteProduct` | YES | UI correctly gates delete to Owner. |
| 9 | `PATCH /products/{id}/activate` | AnyStaff | `activateProduct` | YES | List toggle + detail quick action. |
| 10 | `PATCH /products/{id}/deactivate` | AnyStaff | `deactivateProduct` | YES | — |
| 11 | `PATCH /products/{id}/stock` | AnyStaff | `updateStock` | YES | Detail quick action. |
| 12 | `PATCH /products/{id}/price` | AnyStaff | `updatePrice` | YES | Detail quick action. |
| 13 | `PATCH /products/{id}/discount` | AnyStaff | `updateDiscount` | YES | Detail quick action (null clears). |
| 14 | `POST /products/{id}/duplicate` | AnyStaff | `duplicateProduct` | YES | Detail quick action. |
| 15 | `POST /products/{id}/images` (`files`) | AnyStaff | `uploadImages` | YES | Via product form only. |
| 16 | `PUT /products/{id}/images/{imageId}` (`file`) | AnyStaff | `replaceImage` | YES | Form popup + detail carousel button. |
| 17 | `DELETE /products/{id}/images/{imageId}` | AnyStaff | `deleteImage` | YES | Form popup only (not on detail). |
| 18 | `PATCH /products/{id}/cover-image` | AnyStaff | `setCoverImage` | PARTIAL | Service + `ProductDetailCubit.setCover` exist but **no UI button** invokes them; the form instead batches `coverImageId` into the `PUT`. Endpoint never hit at runtime. |
| 19 | `GET /categories` | AnyStaff | `getCategories` | YES | — |
| 20 | `GET /categories/{id}` | AnyStaff | `getCategory` | PARTIAL | Service method + `CategoryDetail` model exist but are **never called** anywhere. Category edit ignores it (see QA_REPORT #2). |
| 21 | `POST /categories` | **OwnerOrManager** | `createCategory` | YES | Add gated Owner/Manager. |
| 22 | `PUT /categories/{id}` | **OwnerOrManager** | `updateCategory` | PARTIAL | Integrated, but **edit form opens blank** (existing data never loaded) — an "update" overwrites with empty fields (QA_REPORT #2). |
| 23 | `DELETE /categories/{id}` | **OwnerOrManager** | `deleteCategory` | YES | Confirm dialog. Not role-gated in UI (see QA_REPORT #7). |
| 24 | `PATCH /categories/reorder` | **OwnerOrManager** | `reorderCategories` | YES | Drag reorder. |
| 25 | `PATCH /categories/{id}/activate` | **OwnerOrManager** | `activateCategory` | YES | Per-tile toggle. |
| 26 | `PATCH /categories/{id}/deactivate` | **OwnerOrManager** | `deactivateCategory` | YES | — |
| 27 | `GET /orders` | AnyStaff | `getOrders` | YES | Status filter + pagination. |
| 28 | `GET /orders/{id}` | AnyStaff | `getOrder` | YES | — |
| 29 | `PATCH /orders/{id}/status` | AnyStaff | `updateStatus` | YES | UI allows any→any (backend also unvalidated — QA_REPORT #8). |
| 30 | `GET /settings` | AnyStaff | `getEditableSettings` / `getSocial` | YES | — |
| 31 | `PUT /settings` | **OwnerOrManager** | `updateSettings` | YES | Site Customization screen. |
| 32 | `PATCH /settings/social` | **OwnerOrManager** | `updateSocial` | YES | Social Links screen. |
| 33 | `POST /settings/images` (`file`) | **OwnerOrManager** | `uploadImage` | YES | Logo/favicon/hero upload. |
| 34 | `GET /storefront/{shopId}/settings` | Anonymous | `getSettings` | YES | App-wide theming. |
| 35 | `GET /storefront/{shopId}/products` | Anonymous | `StorefrontService.getProducts` | YES | Search/category/price/sort/paging. |
| 36 | `GET /storefront/{shopId}/products/{id}` | Anonymous | `StorefrontService.getProduct` | YES | — |
| 37 | `GET /storefront/{shopId}/categories` | Anonymous | `getCategories` | YES | — |
| 38 | `POST /storefront/{shopId}/orders` | Anonymous (rate-limited) | `placeOrder` | YES | Checkout. |

## Coverage summary

- **Integrated (service call exists):** 38 / 38 = **100%**.
- **Fully reachable (YES):** 33 / 38 = **~87%**.
- **PARTIAL:** 5 — #4 (missing filter params), #6 (create flow broken), #18 (cover-image unreachable), #20 (get-by-id unused), #22 (edit blank).
- **NO:** 0.

## Backend capability areas with NO HTTP endpoint (cannot be integrated yet)

These Application-layer features exist but are **not exposed by any controller** — so they are missing on **both** sides (API + app). They require backend endpoints first, then Flutter screens:

- **Analytics** (`Features/Analytics/*`): page/product view tracking, contact-click tracking, search history, daily aggregates, reporting. No endpoint.
- **Engagement** (`Features/Engagement/*`): comments, reactions/likes, reaction counters. No endpoint.
- **Favorites**: no domain endpoint (storefront web used localStorage). No API.
- **Gallery** (`Domain/Gallery/*`: albums/images): no controller.
- **Occasions** & **Tags** (`Domain/Catalog`): no CRUD endpoint; only usable as `OccasionId`/`TagId` filters and `occasionIds`/`tagIds` on product write — which the app never populates.

See **MISSING_FEATURES.md** for the prioritized list.
