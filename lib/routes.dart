import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/di/service_locator.dart';
import 'package:my_gallery/core/storage/secure_storage.dart';
import 'package:my_gallery/features/auth/data/auth_service.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/auth/presentation/screens/login_screen.dart';
import 'package:my_gallery/features/auth/presentation/screens/splash_screen.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/features/cart/presentation/screens/cart_screen.dart';
import 'package:my_gallery/features/categories/data/models/category_models.dart';
import 'package:my_gallery/features/categories/domain/category_form_cubit.dart';
import 'package:my_gallery/features/categories/presentation/screens/category_form_screen.dart';
import 'package:my_gallery/features/home/presentation/screens/home_screen.dart';
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
import 'package:my_gallery/features/storefront/presentation/screens/storefront_product_detail_screen.dart';
import 'package:my_gallery/features/storefront/presentation/screens/storefront_screen.dart';

final _authCubit = AuthCubit(sl<AuthService>());

final router = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final location = state.matchedLocation;
    final hasSession = await SecureStorage.hasValidSession();
    // Public routes: splash, login, storefront
    final isPublic =
        location == '/home' ||
        location == '/' ||
        location.startsWith('/storefront');
    if (!hasSession && !isPublic) return '/home';
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>
          BlocProvider.value(value: _authCubit, child: const SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) =>
          BlocProvider.value(value: _authCubit, child: const LoginScreen()),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) =>
          BlocProvider.value(value: _authCubit, child: const HomeScreen()),
    ),
    // Static product routes must come before /:id to avoid "create" being parsed as an id
    GoRoute(
      path: '/products/create',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<ProductFormCubit>(),
        child: const ProductFormScreen(),
      ),
    ),
    GoRoute(
      path: '/products/:id/edit',
      builder: (context, state) {
        final product = state.extra as ProductDetail?;
        return BlocProvider(
          create: (_) => sl<ProductFormCubit>(),
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
        final cat = state.extra as CategoryDetail?;
        return BlocProvider(
          create: (_) => sl<CategoryFormCubit>(),
          child: CategoryFormScreen(existing: cat),
        );
      },
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
  ],
);
