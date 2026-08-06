# MISSING_FEATURES.md

> **Implementation update (branch `feature/qa-implementation`)** — see `IMPLEMENTATION_SUMMARY.md`.
> ✅ **Done:** A1 (product category picker), A2 (category edit loads existing), A3 (product detail image
> management), A8 (product category filter), A9 (hero slides rendering).
> ⏸ **Deferred:** A4 (category parent picker), A7 (product extra fields).
> ⛔ **Blocked on new backend endpoints:** A5, A6, and all Class B (B1–B7).

Two classes of gaps:
- **Class A — API exists, app UI missing** (frontend work only).
- **Class B — backend domain exists but no JSON API endpoint** (needs a backend endpoint *first*, then a Flutter screen).

Related Flutter paths are under `D:\المعرض\my_gallery\lib`. Backend paths under `D:\MyGallery project`.

---

## CLASS A — API exists, Flutter UI missing

### A1. Product create — category picker
- **Backend Support:** ✅ `POST /products` requires `CategoryId` (`> 0`), `GET /categories` available.
- **Frontend Support:** ❌ No category selector; `_categoryId` only inherited from an existing product.
- **Priority:** CRITICAL (blocks all product creation).
- **Expected UI:** Required dropdown/searchable picker of active categories in the product form.
- **Required Screen/Button/Dialog:** Category `DropdownButtonFormField` (or picker sheet) in `product_form_screen.dart`.
- **Required Validation:** Category required (replace the snackbar-only guard).
- **Required API:** `GET /categories` (already integrated via `CategoriesCubit`).
- **Backend files:** `MyGallery.Api/Controllers/V1/ProductsController.cs`, `Models/Products/ProductCreateRequest.cs`.
- **Flutter files:** `lib/features/products/presentation/screens/product_form_screen.dart`, `lib/features/categories/domain/categories_cubit.dart`.

### A2. Category edit — load existing data
- **Backend Support:** ✅ `GET /categories/{id}` → `CategoryDetailsDto`.
- **Frontend Support:** ❌ Edit navigates without data; `getCategory` never called; form opens blank.
- **Priority:** CRITICAL (blind save overwrites the category with empty fields).
- **Expected UI:** Edit form pre-populated from `getCategory(id)`.
- **Required Screen/Button:** Fix navigation in `categories_screen.dart`; fetch detail before/inside `category_form_screen.dart`.
- **Required API:** `GET /categories/{id}` (already in service, unused).
- **Flutter files:** `lib/features/categories/presentation/screens/categories_screen.dart` (line ~99), `category_form_screen.dart`, `categories_service.dart`.

### A3. Product full image management on detail screen
- **Backend Support:** ✅ `POST/DELETE /products/{id}/images`, `PATCH /cover-image`.
- **Frontend Support:** ⚠️ Only "replace" on detail; add/delete/set-cover only via form. `ProductDetailCubit.uploadImages/deleteImage/setCover` exist but no buttons.
- **Priority:** High.
- **Expected UI:** On product detail: add-images button, per-image delete, "set as cover" action.
- **Flutter files:** `lib/features/products/presentation/screens/product_detail_screen.dart`, `product_detail_cubit.dart`.

### A4. Category sub-categories (parentId)
- **Backend Support:** ✅ Create/Update accept `ParentId`; cycle detection + parent validation.
- **Frontend Support:** ❌ No parent selector; `CategoryRequest.parentId` unreachable.
- **Priority:** High (data model is a tree; app is flat).
- **Expected UI:** Parent-category dropdown (nullable) in `category_form_screen.dart`; tree/indent display in list.
- **Flutter files:** `category_form_screen.dart`, `categories_screen.dart`, `categories_service.dart`.

### A5. Category image
- **Backend Support:** ✅ Category has `ImageFileId`; Update supports `RemoveImage` + image; images uploaded via product-style flow. (Note: there is **no dedicated category-image upload endpoint**; verify how the MVC dashboard uploads it — may need a backend endpoint.)
- **Frontend Support:** ❌ No image picker; `removeImage` in request unused; `categories_service` has no upload method.
- **Priority:** Medium.
- **Expected UI:** Image picker + preview + remove in category form.
- **Flutter files:** `category_form_screen.dart`, `categories_service.dart`.

### A6. Product tags & occasions association
- **Backend Support:** ✅ `tagIds[]`, `occasionIds[]` on create/update; filters `TagId`/`OccasionId`.
- **Frontend Support:** ❌ No UI; sent empty; no Tag/Occasion models or services.
- **Priority:** Medium.
- **Expected UI:** Multi-select chips for tags and occasions in the product form. (Requires occasion/tag list endpoints — see B6.)
- **Flutter files:** `product_form_screen.dart`, new `tags`/`occasions` service + models.

### A7. Product extra fields (barcode, weight, dimensions)
- **Backend Support:** ✅ `Barcode, Weight, Width, Height, Length` on product.
- **Frontend Support:** ❌ In model/request, no form inputs.
- **Priority:** Low.
- **Flutter files:** `product_form_screen.dart`, `product_models.dart`.

### A8. Product list filter by category (and occasion/tag)
- **Backend Support:** ✅ `CategoryId`, `OccasionId`, `TagId` query params.
- **Frontend Support:** ⚠️ `ProductFilter.categoryId` supported by cubit but filter sheet has no control; occasion/tag not modeled.
- **Priority:** Medium.
- **Expected UI:** Category chips/dropdown in `products_filter_sheet.dart`.
- **Flutter files:** `lib/features/products/presentation/widgets/products_filter_sheet.dart`.

### A9. Hero slides rendering in storefront
- **Backend Support:** ✅ `heroSlides` in settings.
- **Frontend Support:** ⚠️ Authored in Site Customization but **not rendered** in `storefront_screen.dart`.
- **Priority:** Medium (authoring exists but has no end-user effect in-app).
- **Expected UI:** Hero carousel at top of the storefront using `settings.heroSlides` (carousel_slider is already a dependency).
- **Flutter files:** `lib/features/storefront/presentation/screens/storefront_screen.dart`.

---

## CLASS B — Backend domain exists, but NO JSON API (needs backend endpoint first)

> These Application/Domain features live only in the MVC host or are unexposed. The Flutter app **cannot** integrate them until `MyGallery.Api` exposes endpoints. Report both the missing API and the missing screen.

### B1. Favorites / wishlist
- **Backend:** `FavoriteEvent` (analytics) exists; **no API**. MVC storefront used localStorage.
- **Frontend:** ❌.
- **Priority:** High (common storefront expectation).
- **Required API:** favorites add/remove/list per visitor or per user.
- **Required UI:** heart toggles on product cards/detail + favorites screen.

### B2. Product view / analytics tracking
- **Backend:** `PageView`, `ProductView`, `SearchHistory`, `ContactClick`, daily aggregates; MVC `/track/*` only; **no API**.
- **Frontend:** ❌ (though `MostViewed` sort exists, nothing increments views from the app).
- **Priority:** Medium.
- **Required API:** tracking POST endpoints (view, search, contact-click) + read/report endpoints for an admin dashboard.
- **Required UI:** silent tracking calls; optional analytics dashboard screen.

### B3. Comments / reviews
- **Backend:** `Comment` (nested, moderation `CommentStatus`); MVC `CommentsController`/`EngagementController`; **no API**.
- **Frontend:** ❌.
- **Priority:** Medium.
- **Required API:** list/create/moderate comments per entity.
- **Required UI:** comments section on product detail + moderation screen for staff.

### B4. Reactions / likes
- **Backend:** `Reaction`, `ReactionCounter` (`Like`, `Love`); MVC only; **no API**.
- **Frontend:** ❌.
- **Priority:** Low/Medium.
- **Required API:** react/unreact + counts.
- **Required UI:** like button + counter on product detail.

### B5. Gallery albums
- **Backend:** `GalleryAlbum`, `GalleryImage`; MVC only; **no API**.
- **Frontend:** ❌.
- **Priority:** Medium.
- **Required API:** album CRUD + image CRUD.
- **Required UI:** gallery browse (storefront) + album management (admin).

### B6. Occasions & Tags (CRUD / browse)
- **Backend:** `Occasion`, `Tag` entities (global, no ShopId); **no API** (only usable as product write ids/filters).
- **Frontend:** ❌.
- **Priority:** Medium (prerequisite for A6/A8).
- **Required API:** list occasions/tags (+ manage if per-shop desired).
- **Required UI:** selection lists + optional management.

### B7. User / staff management
- **Backend:** `User` entity, `UserRole`, `users.manage` permission (Owner); **no API endpoint** at all.
- **Frontend:** ❌.
- **Priority:** Medium (Owner cannot manage staff from the app).
- **Required API:** user CRUD + role assignment (Owner-gated).
- **Required UI:** staff list + add/edit user screen (Owner only).
