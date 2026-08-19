import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/di/service_locator.dart';
import 'package:my_gallery/core/network/session_notifier.dart';
import 'package:my_gallery/core/session/session_manager.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';
import 'package:my_gallery/features/auth/data/auth_service.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/auth/presentation/screens/login_screen.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/features/cart/presentation/screens/cart_screen.dart';
import 'package:my_gallery/features/categories/domain/categories_cubit.dart';
import 'package:my_gallery/features/categories/domain/category_form_cubit.dart';
import 'package:my_gallery/features/categories/presentation/screens/category_form_screen.dart';
import 'package:my_gallery/features/home/presentation/screens/home_screen.dart';
import 'package:my_gallery/features/occasions/domain/occasion_form_cubit.dart';
import 'package:my_gallery/features/occasions/domain/occasions_cubit.dart';
import 'package:my_gallery/features/occasions/presentation/screens/occasion_form_screen.dart';
import 'package:my_gallery/features/occasions/presentation/screens/occasions_screen.dart';
import 'package:my_gallery/features/orders/domain/order_detail_cubit.dart';
import 'package:my_gallery/features/orders/domain/orders_list_cubit.dart';
import 'package:my_gallery/features/orders/presentation/screens/order_detail_screen.dart';
import 'package:my_gallery/features/orders/presentation/screens/orders_screen.dart';
import 'package:my_gallery/features/products/data/models/product_models.dart';
import 'package:my_gallery/features/products/domain/product_detail_cubit.dart';
import 'package:my_gallery/features/products/domain/product_form_cubit.dart';
import 'package:my_gallery/features/products/presentation/screens/product_detail_screen.dart';
import 'package:my_gallery/features/products/presentation/screens/product_form_screen.dart';
import 'package:my_gallery/features/storefront/data/models/storefront_models.dart';
import 'package:my_gallery/features/storefront/data/storefront_service.dart';
import 'package:my_gallery/features/storefront/domain/checkout_cubit.dart';
import 'package:my_gallery/features/storefront/domain/storefront_cubit.dart';
import 'package:my_gallery/features/storefront/presentation/screens/checkout_screen.dart';
import 'package:my_gallery/features/storefront/presentation/screens/order_success_screen.dart';
import 'package:my_gallery/features/storefront/presentation/screens/occasion_products_screen.dart';
import 'package:my_gallery/features/storefront/presentation/screens/storefront_product_detail_screen.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/features/settings/domain/site_customization_cubit.dart';
import 'package:my_gallery/features/settings/domain/social_links_cubit.dart';
import 'package:my_gallery/core/logging/error_log_entry.dart';
import 'package:my_gallery/features/error_logs/domain/error_logs_cubit.dart';
import 'package:my_gallery/features/error_logs/presentation/screens/error_log_details_screen.dart';
import 'package:my_gallery/features/error_logs/presentation/screens/error_logs_screen.dart';
import 'package:my_gallery/features/settings/presentation/screens/site_customization_screen.dart';
import 'package:my_gallery/features/settings/presentation/screens/social_links_screen.dart';
import 'package:my_gallery/features/storefront/presentation/screens/storefront_screen.dart';
import 'package:my_gallery/features/onboarding/data/onboarding_repository.dart';
import 'package:my_gallery/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:my_gallery/features/store_registration/domain/store_registration_cubit.dart';
import 'package:my_gallery/features/store_registration/presentation/screens/create_store_wizard_screen.dart';

final _authCubit = AuthCubit(
  sl<AuthService>(),
  onSessionCleared: () {
    sl<CartCubit>().clear();
    sl<SettingsCubit>().clearCache();
  },
);

// Onboarding flag — once true it stays true (cannot revert to false).
bool _onboardingDone = false;

// Startup session result pre-resolved in main() before runApp(). Consumed
// once on the first redirect evaluation so no async I/O blocks that call.
// Null after the first evaluation — subsequent calls do a live storage read.
bool? _startupSession;

/// Call this from main() in parallel with other init work (ThemeCubit,
/// SettingsCubit) so both routing decisions are cached before the widget tree
/// builds. This eliminates the blank/dark Flutter frame that would otherwise
/// appear while GoRouter awaits its first async redirect resolution.
Future<void> primeRouterStartupState() async {
  // When the network layer invalidates the session (repeated genuine failures),
  // reset the root auth cubit so the login screen doesn't bounce back to /home.
  // The router redirect (below) does the actual navigation off SessionNotifier.
  SessionManager.instance.bindOnInvalidate(_authCubit.forceUnauthenticated);
  _onboardingDone = await OnboardingRepository().isCompleted();
  _startupSession = await SecureStorage.hasValidSession();
}

final router = GoRouter(
  initialLocation: '/',
  refreshListenable: SessionNotifier.instance,
  redirect: (context, state) async {
    final location = state.matchedLocation;
    if (!_onboardingDone) {
      _onboardingDone = await OnboardingRepository().isCompleted();
    }
    if (!_onboardingDone && location != '/onboarding') return '/onboarding';
    // Use the startup-primed value once (no I/O on the first-frame redirect),
    // then fall back to live storage for every subsequent navigation event.
    final hasSession = _startupSession ?? await SecureStorage.hasValidSession();
    _startupSession = null;
    final isPublic = location == '/' ||
        location.startsWith('/storefront') ||
        location == '/onboarding' ||
        location == '/register';
    if (!hasSession && !isPublic) return '/';
    if (hasSession && location == '/') return '/home';
    return null;
  },
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) =>
          BlocProvider.value(value: _authCubit, child: const LoginScreen()),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) =>
          BlocProvider.value(value: _authCubit, child: const HomeScreen()),
    ),
    // Self-service store creation (public). Shares the root AuthCubit so a
    // successful sign-up can adopt the returned session and land on /home.
    GoRoute(
      path: '/register',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authCubit),
          BlocProvider(create: (_) => sl<StoreRegistrationCubit>()),
        ],
        child: const CreateStoreWizardScreen(),
      ),
    ),
    // Static product routes must come before /:id to avoid "create" being parsed as an id
    GoRoute(
      path: '/products/create',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<ProductFormCubit>()),
          BlocProvider(create: (_) => sl<CategoriesCubit>()),
          BlocProvider(create: (_) => sl<OccasionsCubit>()),
        ],
        child: const ProductFormScreen(),
      ),
    ),
    GoRoute(
      path: '/products/:id/edit',
      builder: (context, state) {
        final product = state.extra as ProductDetail?;
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<ProductFormCubit>()),
            BlocProvider(create: (_) => sl<CategoriesCubit>()),
            BlocProvider(create: (_) => sl<OccasionsCubit>()),
          ],
          child: ProductFormScreen(existing: product),
        );
      },
    ),
    GoRoute(
      path: '/products/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _authCubit),
            BlocProvider(create: (_) => sl<ProductDetailCubit>()),
          ],
          child: ProductDetailScreen(productId: id),
        );
      },
    ),
    // Static category routes before /:id
    GoRoute(
      path: '/categories/create',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<CategoryFormCubit>(),
        child: const CategoryFormScreen(),
      ),
    ),
    GoRoute(
      path: '/categories/:id/edit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (_) => sl<CategoryFormCubit>(),
          child: CategoryFormScreen(editId: id),
        );
      },
    ),

    // ------------------------------------
    // Occasions (staff)
    // ------------------------------------
    GoRoute(
      path: '/occasions',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _authCubit),
          BlocProvider(create: (_) => sl<OccasionsCubit>()),
        ],
        child: const OccasionsScreen(),
      ),
    ),
    GoRoute(
      path: '/occasions/create',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<OccasionFormCubit>(),
        child: const OccasionFormScreen(),
      ),
    ),
    GoRoute(
      path: '/occasions/:id/edit',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (_) => sl<OccasionFormCubit>(),
          child: OccasionFormScreen(editId: id),
        );
      },
    ),

    // ------------------------------------
    // Settings
    // ------------------------------------
    GoRoute(
      path: '/settings/social',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<SocialLinksCubit>(),
        child: const SocialLinksScreen(),
      ),
    ),
    GoRoute(
      path: '/settings/appearance',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<SiteCustomizationCubit>(),
        child: const SiteCustomizationScreen(),
      ),
    ),

    // ------------------------------------
    // Storefront (public — no auth required)
    // ------------------------------------
    GoRoute(
      path: '/storefront',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<StorefrontCubit>()),
          BlocProvider.value(value: sl<CartCubit>()),
        ],
        child: const StorefrontScreen(),
      ),
    ),
    GoRoute(
      path: '/storefront/cart',
      builder: (context, state) =>
          BlocProvider.value(value: sl<CartCubit>(), child: const CartScreen()),
    ),
    GoRoute(
      path: '/storefront/checkout',
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => sl<CheckoutCubit>()),
          BlocProvider.value(value: sl<CartCubit>()),
        ],
        child: const CheckoutScreen(),
      ),
    ),
    GoRoute(
      path: '/storefront/success',
      builder: (context, state) {
        final result = state.extra as PlaceOrderResult;
        return OrderSuccessScreen(result: result);
      },
    ),
    GoRoute(
      path: '/storefront/occasions/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        final name = state.extra as String?;
        return MultiBlocProvider(
          providers: [
            RepositoryProvider.value(value: sl<StorefrontService>()),
            BlocProvider.value(value: sl<CartCubit>()),
          ],
          child: OccasionProductsScreen(occasionId: id, occasionName: name),
        );
      },
    ),
    GoRoute(
      path: '/storefront/products/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return MultiBlocProvider(
          providers: [
            RepositoryProvider.value(value: sl<StorefrontService>()),
            BlocProvider.value(value: sl<CartCubit>()),
          ],
          child: StorefrontProductDetailScreen(productId: id),
        );
      },
    ),

    // ------------------------------------
    // Orders (staff)
    // ------------------------------------
    GoRoute(
      path: '/orders',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<OrdersListCubit>(),
        child: const OrdersScreen(),
      ),
    ),
    GoRoute(
      path: '/orders/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return BlocProvider(
          create: (_) => sl<OrderDetailCubit>(),
          child: OrderDetailScreen(orderId: id),
        );
      },
    ),

    // ------------------------------------
    // Developer: Error Logs
    // ------------------------------------
    GoRoute(
      path: '/error-logs',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<ErrorLogsCubit>(),
        child: const ErrorLogsScreen(),
      ),
    ),
    GoRoute(
      path: '/error-logs/:id',
      builder: (context, state) {
        final entry = state.extra as ErrorLogEntry;
        return ErrorLogDetailsScreen(entry: entry);
      },
    ),
  ],
);
