# CLAUDE.md

Guidance for Claude Code when working in this repository.

## Commands

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs   # after any @freezed / @JsonSerializable change
flutter run --dart-define=SHOP_ID=2                                # SHOP_ID selects the gallery
flutter analyze
flutter test
flutter build apk        # / appbundle
```

## What this app is

A dynamic, white-label Flutter admin + storefront for an Arabic e-commerce gallery. A single binary
serves any gallery: brand name, logo, colors, fonts, and hero slides are fetched at runtime from the
backend shop settings — nothing about a specific gallery is hardcoded.

- Admin (`/home`, `/products/*`, `/categories/*`, `/orders/*`) — JWT access-token auth.
- Storefront (`/storefront/*`) — public, anonymous, keyed by shop id.

## Backend contract (`/api/v1`, envelope `{success,message,data,errors,traceId,pagination}`)

Auth (access-token only — **no refresh tokens**):

- `POST /auth/login` → `{ accessToken, expiresAt, user{ id, fullName, email, role, shopId, shopName, permissions[] } }`
- `POST /auth/logout` (bearer, no body) · `GET /auth/me`

Products (staff, shop from token):

- `GET /products` (search/filter/sort/paged) · `GET /products/{id}` · `POST /products` · `PUT /products/{id}` · `DELETE /products/{id}`
- `PATCH /products/{id}/activate|deactivate|stock|price|discount` · `POST /products/{id}/duplicate`
- `POST /products/{id}/images` (multipart `files`) · **`PUT /products/{id}/images/{imageId}`** (multipart `file`, replace)
- `DELETE /products/{id}/images/{imageId}` · `PATCH /products/{id}/cover-image`

Categories (staff): `GET/POST /categories`, `GET/PUT/DELETE /categories/{id}`, activate/deactivate, reorder.

Orders (staff): `GET /orders`, `GET /orders/{id}`, status transitions.

Settings (staff): `GET /settings`, `PUT /settings` (Owner/Manager) — the shop's visual identity.

Storefront (public): `GET /storefront/{shopId}/settings|products|products/{id}|categories`, `POST /storefront/{shopId}/orders`.

## Dynamic identity & theming

- `features/settings/` fetches `GET /storefront/{shopId}/settings` → `StorefrontSettings`
  (`brandName`, `logo`, `favicon`, palette colors, `borderRadius`, `fontFamily`, `heroSlides[]`).
- `SettingsCubit` (singleton) caches settings in `shared_preferences`; loaded in `main.dart` before `runApp`.
- `AppTheme.build(settings, brightness)` in `lib/theme.dart` builds light & dark `ThemeData` from the palette.
- `ThemeCubit` (singleton) holds `ThemeMode` (system/light/dark), persisted; toggled from the profile screen.
- Active shop id: staff ⇒ `AuthUser.shopId`; storefront ⇒ `AppConfig.shopId` from `--dart-define=SHOP_ID`.
  Never a literal `2`.
- `kDefaultSettings` (`const StorefrontSettings(brandName: 'معرضي')`) is the compile-time fallback used
  before settings load; it uses the same color defaults as the current theme constants.
- `SessionNotifier.instance` is a `ChangeNotifier` wired to `GoRouter.refreshListenable`. On 401, the
  interceptor calls `SessionNotifier.instance.invalidate()`, clears the token, and GoRouter's redirect
  automatically bounces to `/` (login).

## Architecture

Feature-first under `lib/features/<name>/{data,domain,presentation}`:

- `data/<name>_service.dart` — raw Dio; `data/models/*` — `@freezed` + `@JsonSerializable`.
- `domain/<name>_cubit.dart` — Cubit with a `@freezed` state union (`initial/loading/loaded/error`).
- `presentation/screens|widgets`.

DI (`core/di/service_locator.dart`, get_it):

- **Lazy singletons**: Services + `CartCubit` + `SettingsCubit` + `ThemeCubit`.
- **Factories**: all other Cubits (fresh instance per widget tree).

Routing (`routes.dart`, GoRouter):

- `refreshListenable: SessionNotifier.instance` — 401 mid-session auto-redirects to login.
- `redirect` guard on `SecureStorage.hasValidSession()`; static routes before parameterized ones.

Network (`core/network/api_client.dart`):

- One shared Dio; interceptor attaches Bearer token.
- On 401: clears session, calls `SessionNotifier.instance.invalidate()`, raises `unauthorized`.
- All errors flow through `ApiException.fromDio()` into `ApiException{ kind, message, statusCode, traceId, errors[] }`.
- `ApiErrorKind` enum: `network, timeout, unauthorized, forbidden, notFound, validation, conflict, rateLimited, server, unknown`.
- `exceptionFromDio(DioException)` is the single unwrap point used in all services.

Storage:

- `flutter_secure_storage` → access token + expiry only (no refresh tokens).
- `shared_preferences` → cart, cached settings JSON, theme mode.

State: sealed `@freezed` unions consumed via `BlocBuilder` + `state.when(...)`.
Every list/detail screen renders the error state with a message + Retry; no `catch (_) {}`.

## Localization & layout

Default locale Arabic (`ar`), RTL. Font family from `settings.fontFamily` (Tajawal fallback via
`GoogleFonts`). Responsive baseline 390×844 via `flutter_screenutil`.
Error message keys in `lib/l10n/app_ar.arb` / `app_en.arb`: `error_network`, `error_timeout`,
`error_unauthorized`, `error_forbidden`, `error_not_found`, `error_validation`, `error_conflict`,
`error_rate_limited`, `error_server`, `error_unknown`.

Reuse `lib/core/components/*` over raw Material widgets.

## When adding a feature

1. Model (`@freezed`) → run `build_runner`.
2. Service (Dio, throws mapped `ApiException` via `exceptionFromDio`).
3. Cubit (`@freezed` state).
4. Register in `service_locator.dart`.
5. Route in `routes.dart`.
6. Screen consuming `state.when`, error state with Retry.
7. Keep identity/colors/strings dynamic — never hardcode a gallery name or literal `shopId`.
