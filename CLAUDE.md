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
- The product form manages images inline: pick new files, replace an existing image's file, delete images,
  and change cover. Deletions + cover change are batched into the `PUT` via `removeImageIds[]` + `coverImageId`;
  new images are uploaded via `POST .../images` after the product row is saved; replacements via `PUT .../images/{id}`.
  `lib/features/products/data/image_rules.dart` enforces allowed types (`jpg,jpeg,png,webp,gif`) and 5 MB
  limit client-side (UI) and inside `uploadImages` before any multipart call.

Categories (staff): `GET/POST /categories`, `GET/PUT/DELETE /categories/{id}`, activate/deactivate, reorder.

Orders (staff): `GET /orders`, `GET /orders/{id}`, status transitions.

Settings (staff): `GET /settings` (any staff, full identity incl. colors/radius/font), `PUT /settings`
(Owner/Manager — **full replace**: send every field or the server resets it), `POST /settings/images`
(Owner/Manager, multipart `file` → `{ url, fileName, size, contentType }`; jpeg/png/webp/gif ≤ 5 MB),
`PATCH /settings/social`. On the wire `borderRadius` is a **CSS string** (`"16px"`, parsed to `double` via
`radiusFromJson`) and colors are `#RRGGBB` strings.

The in-app **Site Customization** screen (`/settings/appearance`, Owner/Manager) edits the full identity —
brand name, logo, favicon, website, 6 colors, corner radius, font, hero slides, social — via
`SiteCustomizationCubit` (factory). Logo/favicon/hero images upload through `POST /settings/images`, then
the whole object is saved via `PUT /settings`; on success the cubit calls `SettingsCubit.applyUpdated(...)`
so the app restyles live.

Storefront (public): `GET /storefront/{shopId}/settings|products|products/{id}|categories`, `POST /storefront/{shopId}/orders`.

## Dynamic identity & theming

- `features/settings/` fetches `GET /storefront/{shopId}/settings` → `StorefrontSettings`
  (`brandName`, `logo`, `favicon`, `heroSlides[]`, `social{ instagram, facebook, whatsApp }`, `website`).
- Every UI text that shows the gallery name reads `SettingsCubit.currentOrDefault.brandName`; the website
  button (profile screen + home AppBar icon) reads `.website` and hides when empty. No literal gallery name
  or URL is ever hardcoded — `kDefaultSettings` is the only allowed fallback.
- `SettingsCubit` (singleton) caches settings in `shared_preferences`; loaded in `main.dart` before `runApp`.
- `AppTheme.build(brightness, ThemePalette)` in `lib/theme.dart` builds light & dark `ThemeData` from a
  `ThemePalette` (6 role colors + `radius` + `fontFamily`). The live palette is chosen by
  `activePalette(settings, source)`: `ThemeSource.identity` → `ThemePalette.fromSettings(settings)` (the
  shop's server-driven colors), `ThemeSource.appDefault` → the built-in `kDefaultPalette` (attractive,
  brand-neutral). `ThemeCubit` persists a `ThemeSettings{ mode, source }` in shared_preferences; `main.dart`
  rebuilds on both `SettingsCubit` and `ThemeCubit` and passes the resolved palette into `AppTheme.build`.
  Font is `GoogleFonts.getFont(fontFamily)` (Tajawal/Cairo, `supportedFonts`; unknown → Tajawal).
  - Color strategy: `ColorScheme.fromSeed(seedColor: palette.primary, brightness: brightness)` generates all M3
    tonal tokens. Use the computed tokens (`outlineVariant`, `onSurfaceVariant`, `surfaceContainerHighest`, …)
    for borders/secondary text/surfaces. Never use raw `Color(…)` or named `Colors.*` in screens — always
    derive from the active colorScheme or `AppColors` semantic constants.
  - Font: Tajawal (GoogleFonts), hardcoded. Border radius: 16 dp, hardcoded.
- `lib/core/constants/colors.dart` (`AppColors`) holds fixed semantic colors that don't change with
  light/dark mode: order/product status colors, WhatsApp brand green, image scrim. Use these only when the
  color has a fixed semantic meaning that is independent of the theme (e.g. WhatsApp green, active badge).
- `ThemeCubit` (singleton) holds `ThemeSettings{ mode, source }` — `mode` (system/light/dark) via
  `setMode`/`toggle`, and `source` (`identity`|`appDefault`) via `setThemeSource` — both persisted to
  shared_preferences. Users toggle mode via the animated sun/moon `ThemeToggleButton` widget
  (`lib/shared/widgets/theme_toggle_button.dart`) present in every tab's AppBar. Default is `ThemeMode.system`.
- **Single AppBar rule**: `HomeScreen` is a bare Scaffold (no AppBar) that hosts the `BottomNavigationBar`
  and `IndexedStack`. Each tab screen owns its own `Scaffold` + `AppBar`, preventing double-bar rendering.
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
8. Colors: `Theme.of(context).colorScheme.*` for all UI chrome; `AppColors.*` only for fixed semantic
   colors (status badges, brand colors). Never use raw `Colors.red`, `Colors.grey`, etc. in screens.
