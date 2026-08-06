# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Install / clean
flutter pub get
flutter clean && flutter pub get

# Code generation (required after changing any @freezed or @JsonSerializable model)
flutter pub run build_runner build --delete-conflicting-outputs

# Run & build
flutter run                          # debug
flutter build apk                    # Android APK
flutter build appbundle              # Android App Bundle (Play Store)

# Quality
flutter analyze
flutter test
```

## Architecture

This is a Flutter admin + storefront app for an Arabic e-commerce gallery. The app serves two roles:

- **Admin** (`/`, `/home`, `/products/*`, `/categories/*`, `/orders/*`) — requires authentication
- **Storefront** (`/storefront/*`) — public, no auth required

### Feature Structure

Each feature under `lib/features/` follows a three-layer split:

```
features/<name>/
  data/
    <name>_service.dart        # Raw HTTP via Dio (no Retrofit generator used)
    models/
      <name>_models.dart       # @freezed + @JsonSerializable data classes
      *.freezed.dart / *.g.dart
  domain/
    <name>_cubit.dart          # BLoC Cubit with @freezed state union
    *.freezed.dart
  presentation/
    screens/
    widgets/
```

### Dependency Injection (`lib/core/di/service_locator.dart`)

Uses `get_it`. Registration rules:
- **Lazy singletons** — all Services + `CartCubit` (cart persists across screens)
- **Factories** — all other Cubits (fresh instance per route)

### Routing (`lib/routes.dart`)

GoRouter with a `redirect` guard that checks `SecureStorage.hasValidSession()`. Static routes are declared before parameterized ones to prevent conflicts. Auth-protected routes redirect to `/` (login) when no valid session exists.

### Network (`lib/core/network/api_client.dart`)

Singleton `Dio` instance with an interceptor that:
1. Attaches the Bearer token from `SecureStorage` to every request
2. On 401, calls the refresh endpoint, saves new tokens, and retries the original request once

### Storage (`lib/core/storage/secure_storage.dart`)

- **`flutter_secure_storage`** (encrypted) — JWT access token, refresh token, expiry
- **`shared_preferences`** — cart contents (serialized JSON)

### State Pattern

States are sealed unions via `freezed`:

```dart
@freezed
class ProductsState with _$ProductsState {
  const factory ProductsState.initial() = _Initial;
  const factory ProductsState.loading() = _Loading;
  const factory ProductsState.loaded(List<Product> products) = _Loaded;
  const factory ProductsState.error(String message) = _Error;
}
```

Consume with `BlocBuilder<XCubit, XState>` and `state.when(...)`.

### API Config (`lib/core/config/app_config.dart`)

```dart
baseUrl  = 'https://alqaleatalsaghira-codetechsyria.com'
apiPrefix = '/api/v1'
shopId   = 2   // demo/staff shop ID sent with product listing requests
```

### Localization & Layout

- Default locale: Arabic (`ar`), RTL layout
- Font: Tajawal (Google Fonts) — supports Arabic script
- Responsive baseline: 390×844 via `flutter_screenutil`
- `Directionality` widget wraps RTL-sensitive subtrees

### Reusable Components

Shared UI lives in `lib/core/components/` — prefer these over raw Material widgets:
`AppButton`, `AppTextField`, `AppCard`, `AppSnackbar`, `AppDrawer`, `AppPagination`, shimmer loaders.
