# FEATURE_MATRIX.md — Backend vs Flutter

> **Implementation update (branch `feature/qa-implementation`)** — see `IMPLEMENTATION_SUMMARY.md`.
> Now **Complete**: Product create (category picker), Category edit (loads existing),
> Delete image on detail, Product image mgmt on detail, Filter by category, Hero slides rendering.
> Now **Partial→better**: validation error surfacing. Frontend changes pending `flutter analyze`/run.

**Backend (source of truth):** `D:\MyGallery project` — .NET 10, `MyGallery.Api` (JSON REST, JWT) + `MyGallery` (MVC storefront/dashboard, cookie auth). The Flutter app consumes **only** `MyGallery.Api`.
**Frontend:** `D:\المعرض\my_gallery` — Flutter admin + storefront.

Status legend: **Complete** = backend capability fully usable in the app · **Partial** = integrated but broken/limited/unreachable · **Missing** = no usable app support · **No API** = backend domain exists but no HTTP endpoint (app cannot integrate until backend exposes it).

## Auth & session
| Feature | Backend | Flutter | Status |
|---|---|---|---|
| Login (JWT access token) | ✅ `POST /auth/login` | ✅ LoginScreen | Complete |
| Current user (`/me`) | ✅ | ✅ getMe | Complete |
| Logout | ✅ (stateless) | ✅ | Complete |
| Refresh token | ❌ removed by design | ❌ (none) | Complete (parity) |
| Role-based gating (Owner/Manager/Employee) | ✅ policies | ⚠️ partial (some screens not gated) | Partial |

## Products
| Feature | Backend | Flutter | Status |
|---|---|---|---|
| List (paged) | ✅ | ✅ infinite scroll | Complete |
| Detail | ✅ | ✅ | Complete |
| **Create** | ✅ `POST /products` (CategoryId required) | ⚠️ **no category picker → cannot create** | **Partial (broken)** |
| Update | ✅ | ✅ (can't change category) | Partial |
| Delete (Owner) | ✅ OwnerOnly | ✅ Owner-gated | Complete |
| Activate / Deactivate | ✅ | ✅ | Complete |
| Stock / Price / Discount edit | ✅ | ✅ detail quick actions | Complete |
| Duplicate | ✅ | ✅ | Complete |
| Search | ✅ (name/SKU) | ✅ | Complete |
| Sort (5 modes) | ✅ | ✅ | Complete |
| Filter by price / status | ✅ | ✅ | Complete |
| **Filter by category** | ✅ `CategoryId` | ❌ no UI control | Missing (UI) |
| Filter by occasion / tag | ✅ `OccasionId`/`TagId` | ❌ | Missing (UI) |
| Upload images | ✅ | ✅ (form) | Complete |
| Replace image | ✅ | ✅ | Complete |
| Delete image | ✅ | ⚠️ form only (not on detail) | Partial |
| Set cover image | ✅ `PATCH /cover-image` | ⚠️ form batches into PUT; PATCH endpoint unreachable | Partial |
| Tags / Occasions association | ✅ `tagIds`/`occasionIds` | ❌ no UI (sent empty) | Missing (UI) |
| Barcode / Weight / Dimensions | ✅ fields | ❌ no form inputs | Missing (UI) |

## Categories
| Feature | Backend | Flutter | Status |
|---|---|---|---|
| List | ✅ (not paged) | ✅ | Complete |
| Get by id | ✅ `GET /categories/{id}` | ⚠️ service exists, never called | Partial |
| Create (Owner/Manager) | ✅ | ✅ | Complete |
| **Update** | ✅ | ⚠️ **edit form opens blank** (existing not loaded) | **Partial (broken)** |
| Delete | ✅ (blocks if children/products) | ✅ confirm dialog | Complete |
| Activate / Deactivate | ✅ OwnerOrManager | ✅ toggle (not role-gated in UI) | Partial |
| Reorder | ✅ | ✅ drag | Complete |
| Sub-categories (parentId, tree) | ✅ + cycle detection | ❌ no parent selector | Missing (UI) |
| Category image | ✅ (File + removeImage) | ❌ no picker; no upload service method | Missing (UI) |
| Search / Filter / Pagination | ❌ (list returns all) | ❌ | N/A (parity) |

## Orders
| Feature | Backend | Flutter | Status |
|---|---|---|---|
| List (paged, status filter) | ✅ | ✅ | Complete |
| Detail | ✅ | ✅ | Complete |
| Update status | ✅ (unvalidated any→any) | ✅ (also unvalidated) | Complete (both lack workflow guard) |
| Place order (public) | ✅ storefront | ✅ checkout | Complete |
| WhatsApp contact | — | ✅ launch | Complete |

## Settings / Identity / Theming
| Feature | Backend | Flutter | Status |
|---|---|---|---|
| Get settings (staff + public) | ✅ | ✅ | Complete |
| Update full settings (Owner/Manager) | ✅ `PUT /settings` | ✅ Site Customization | Complete |
| Colors / radius / font | ✅ (borderRadius="16px") | ✅ (added; radiusFromJson) | Complete |
| Hero slides authoring | ✅ | ✅ editor | Complete |
| **Hero slides rendering** | ✅ data | ❌ not shown in storefront | Missing (UI) |
| Social links | ✅ `PATCH /settings/social` | ✅ | Complete |
| Image upload (logo/favicon/hero) | ✅ `POST /settings/images` | ✅ | Complete |
| Website link | ✅ | ✅ | Complete |
| Light/Dark + theme source | — (app-only) | ✅ | Complete |
| **User management** | ⚠️ User entity + `users.manage` perm, **no endpoint** | ❌ | No API |

## Storefront / Engagement / Analytics (backend domain exists, no JSON API)
| Feature | Backend (API) | Flutter | Status |
|---|---|---|---|
| Storefront browse / product / categories | ✅ | ✅ | Complete |
| Cart + checkout | ✅ (order) | ✅ | Complete |
| **Favorites / wishlist** | ❌ no API (MVC localStorage only) | ❌ | No API |
| **Analytics / view tracking** | ❌ no API (MVC `/track/*` only) | ❌ | No API |
| **Comments / reviews** | ❌ no API (MVC only) | ❌ | No API |
| **Reactions / likes** | ❌ no API (MVC only) | ❌ | No API |
| **Gallery albums** | ❌ no API (MVC only) | ❌ | No API |
| **Occasions (CRUD/browse)** | ❌ no API (global entity) | ❌ | No API |
| **Tags (CRUD/browse)** | ❌ no API (global entity) | ❌ | No API |

## Rollup
- **Complete:** ~30 capabilities.
- **Partial (integrated but broken/limited/unreachable):** 10 — create product, update product (category), delete image on detail, set-cover endpoint, get-category unused, category update (blank), category activate gating, get-by-id, role gating, images-serving.
- **Missing (API exists, UI absent):** category parent, category image, product tags/occasions, product extra fields, category/occasion/tag product filters, hero rendering.
- **No API (backend domain only, needs endpoint first):** favorites, analytics, comments, reactions, gallery, occasions/tags CRUD, user management.
