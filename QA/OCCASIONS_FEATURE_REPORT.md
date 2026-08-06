# OCCASIONS_FEATURE_REPORT.md

Complete "Occasions" management system — lets customers browse products by occasion
(Wedding, Birthday, Graduation, New Baby, Ramadan, Eid, Valentine, Mother's Day, …)
and lets Owner/Manager manage occasions and assign them to products.

Branch (both repos): **`feature/qa-implementation`** (local only — not pushed/merged).

## ⚠️ Verification status
- **Backend**: fully implemented and **`dotnet build` clean (0 warnings / 0 errors, .NET 10)**. Migration generated. `dotnet test`: **no test project exists** in the solution (tests are marked "planned"), so there is nothing to run.
- **Frontend**: fully implemented but **NOT verifiable in this environment** — installed Flutter 3.38.4 < required ~3.44.9, and new `@freezed` models require `build_runner`. Must run: `flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs && flutter analyze`. See `QA/PUSH_BLOCKERS.md`.

## Design decision
Occasions are a **global (shared) catalog lookup** in this codebase — the `Occasion` entity has **no `ShopId`** (unlike `Category`). The feature was built to respect that existing architecture: a dedicated global `IOccasionRepository`, no shop scoping. Staff of any shop read/manage the shared occasion list; products (shop-scoped) link to occasions via the existing `Product ↔ ProductOccasion ↔ Occasion` many-to-many.

---

## Backend changes (`D:\MyGallery project`)

### Domain / Database
- `Occasion` entity gained **`Slug`** (URL-friendly, unique) and **`Icon`**, plus an **`ImageFile`** navigation (mirrors `Category`) for image handling. — `MyGallery.Domain/Catalog/Tables/Occasion.cs`
- `OccasionConfiguration`: `Slug` (maxlen 200) + **filtered unique index** (`[Slug] IS NOT NULL AND [Slug] <> ''`, so legacy null/empty rows don't collide), `Icon` (maxlen 100), `ImageFile` FK (Restrict). — `.../Configurations/Catalog/OccasionConfiguration.cs`
- **Migration** `20260806215148_AddOccasionSlugAndIcon` — adds `Slug` + `Icon` (both nullable → applies cleanly to existing data) + unique index. Apply with:
  `dotnet ef database update --project MyGallery.Infrastructure --startup-project MyGallery.Api`
- **Seed**: the 8 demo occasions now carry English slugs (`wedding`, `birthday`, `graduation`, `mothers-day`, `valentine`, `new-baby`, `congratulations`, `anniversary`). Product↔Occasion links were already seeded. — `.../Seed/DatabaseSeeder.cs`

### Application layer (`Features/Catalog/Occasions/`)
- `IOccasionRepository` + `OccasionRepository` (global; List/ActiveList/Details/DetailsBySlug/ForUpdate/TrackedByIds/SlugExists/Add/Remove/Save).
- DTOs: `OccasionListDto`, `OccasionDetailsDto`, `OccasionCreateDto`, `OccasionUpdateDto`.
- Commands: `CreateOccasion` (+validator), `UpdateOccasion` (+validator), `DeleteOccasion`, `SetOccasionActive`, `ReorderOccasions`, `SetOccasionImage`.
- Queries: `GetOccasions`, `GetOccasionById`, `GetOccasionBySlug`.
- `SlugHelper` (Common) — generates unique ASCII slugs (falls back / de-duplicates with numeric suffix).
- Registered in `ApplicationDependencyInjection` + `InfrastructureDependencyInjection`.

### API changes (endpoints)
Occasions (staff; reads = `AnyStaff`, writes = `OwnerOrManager` — mirrors Categories):

| Method + Route | Purpose |
|---|---|
| `GET /api/v1/occasions` | List all (with product counts) |
| `GET /api/v1/occasions/{id}` | Get by id |
| `GET /api/v1/occasions/slug/{slug}` | Get by slug |
| `POST /api/v1/occasions` | Create |
| `PUT /api/v1/occasions/{id}` | Update |
| `DELETE /api/v1/occasions/{id}` | Delete (product links auto-removed) |
| `PATCH /api/v1/occasions/reorder` | Reorder |
| `PATCH /api/v1/occasions/{id}/activate` \| `/deactivate` | Status |
| `POST /api/v1/occasions/{id}/image` | Upload + attach image (multipart `file`) |

Storefront (public):
| Method + Route | Purpose |
|---|---|
| `GET /api/v1/storefront/{shopId}/occasions` | Active occasions to browse |
| `GET /api/v1/storefront/{shopId}/products?occasionId=` | Products for an occasion (new `occasionId` filter) |

Admin product filtering by occasion already existed (`GET /products?occasionId=`), and product create/update already accept `occasionIds[]`.

---

## Frontend changes (`D:\المعرض\my_gallery`)

### New feature module `lib/features/occasions/`
- `data/models/occasion_models.dart` — `OccasionListItem`, `OccasionDetail`, `OccasionRequest` (freezed).
- `data/occasions_service.dart` — full CRUD + reorder + activate/deactivate + image upload + by-slug.
- `domain/occasions_cubit.dart` — list (load/refresh/toggleActive/reorder/delete/uploadImage).
- `domain/occasion_form_cubit.dart` — loadDetail/create/update (with optional image).
- `presentation/screens/occasions_screen.dart` — admin list (reorderable, role-gated, shimmer/empty/error).
- `presentation/screens/occasion_form_screen.dart` — create/edit (name, slug, description, icon, order, active, image picker; loads existing on edit).

### Screens added / changed
- **Occasions management** (list + form) — `/occasions`, `/occasions/create`, `/occasions/:id/edit`.
- **Home "مناسبات مميّزة" strip** on the storefront (`storefront_screen.dart`) → tapping opens the occasion.
- **Occasion products screen** — `storefront/presentation/screens/occasion_products_screen.dart`, route `/storefront/occasions/:id` (paged product grid).
- **Product form** — occasion multi-select (`FilterChip`s) that preserves/edits `occasionIds`.
- **Product detail** — "مناسب لـ" occasion chips (resolves ids → names).
- **Profile** — Owner/Manager tile "إدارة المناسبات" → `/occasions`.

### Wiring
- DI: `OccasionsService` (singleton), `OccasionsCubit` + `OccasionFormCubit` (factories) — `service_locator.dart`.
- Routes: occasion admin + storefront routes; `OccasionsCubit` added to the product form routes — `routes.dart`.
- Storefront service: `getOccasions()` + `occasionId` param — `storefront_service.dart`.

---

## Files changed

**Backend (new):** `Features/Catalog/Occasions/**` (DTOs, Commands, Queries), `Interfaces/IOccasionRepository.cs`, `Common/SlugHelper.cs`, `Persistence/Repositories/OccasionRepository.cs`, `Api/Controllers/V1/OccasionsController.cs`, `Api/Models/Occasions/**`, migration `..._AddOccasionSlugAndIcon.*`.
**Backend (modified):** `Domain/Catalog/Tables/Occasion.cs`, `Configurations/Catalog/OccasionConfiguration.cs`, `DependencyInjection/{Application,Infrastructure}DependencyInjection.cs`, `Api/Controllers/V1/StorefrontController.cs`, `Api/Models/Storefront/StorefrontProductListRequest.cs`, `Seed/DatabaseSeeder.cs`.
**Frontend (new):** `lib/features/occasions/**`, `lib/features/storefront/presentation/screens/occasion_products_screen.dart`.
**Frontend (modified):** `lib/core/di/service_locator.dart`, `lib/routes.dart`, `lib/features/profile/presentation/screens/profile_screen.dart`, `lib/features/storefront/data/storefront_service.dart`, `lib/features/storefront/presentation/screens/storefront_screen.dart`, `lib/features/products/presentation/screens/product_form_screen.dart`, `lib/features/products/presentation/screens/product_detail_screen.dart`.

---

## Testing results
- **Backend `dotnet build`**: ✅ clean (0/0) after every commit.
- **`dotnet test`**: n/a — no test project in the solution.
- **Frontend `flutter analyze` / `flutter test`**: ⛔ not run (environment SDK mismatch — see PUSH_BLOCKERS). The code follows the existing Categories patterns 1:1; the reviewer must run codegen + analyze.
- **Manual flow testing**: not executed here (needs a running API + SQL Server + the Flutter app). Suggested flows are in PUSH_BLOCKERS.

## Not included (documented follow-ups)
- **Local occasion cache** (cache list/images/order, load-first-then-refresh): deferred to keep the unverified surface bounded; recommended as a small follow-up mirroring `SettingsCubit`'s shared_preferences cache.
- **Search by occasion text** (typing "wedding" in product search): products search matches name/SKU server-side; occasion browsing is via the occasion tiles/filter. Extending free-text search to occasions is a backend `ProductRepository` change.
- Product **tags** are still not editable in the app (pre-existing gap A6, out of this mission's scope) — editing a product continues to clear `tagIds`. Occasions are now preserved/edited.
