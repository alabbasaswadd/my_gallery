import 'package:get_it/get_it.dart';
import 'package:my_gallery/core/network/api_client.dart';
import 'package:my_gallery/features/auth/data/auth_service.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/features/categories/data/categories_service.dart';
import 'package:my_gallery/features/categories/domain/categories_cubit.dart';
import 'package:my_gallery/features/categories/domain/category_form_cubit.dart';
import 'package:my_gallery/features/orders/data/orders_service.dart';
import 'package:my_gallery/features/orders/domain/order_detail_cubit.dart';
import 'package:my_gallery/features/orders/domain/orders_list_cubit.dart';
import 'package:my_gallery/features/products/data/products_service.dart';
import 'package:my_gallery/features/products/domain/product_detail_cubit.dart';
import 'package:my_gallery/features/products/domain/product_form_cubit.dart';
import 'package:my_gallery/features/products/domain/products_list_cubit.dart';
import 'package:my_gallery/features/settings/data/settings_service.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/features/settings/domain/social_links_cubit.dart';
import 'package:my_gallery/features/settings/domain/theme_cubit.dart';
import 'package:my_gallery/features/storefront/data/storefront_service.dart';
import 'package:my_gallery/features/storefront/domain/checkout_cubit.dart';
import 'package:my_gallery/features/storefront/domain/storefront_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services — lazy singletons (one Dio instance shared)
  sl.registerLazySingleton(() => AuthService(dio: ApiClient.dio));
  sl.registerLazySingleton(() => ProductsService(dio: ApiClient.dio));
  sl.registerLazySingleton(() => CategoriesService(dio: ApiClient.dio));
  sl.registerLazySingleton(() => StorefrontService(dio: ApiClient.dio));
  sl.registerLazySingleton(() => OrdersService(dio: ApiClient.dio));
  sl.registerLazySingleton(() => SettingsService(dio: ApiClient.dio));

  // Singletons — shared state across the app
  sl.registerLazySingleton(() => CartCubit());
  sl.registerLazySingleton(() => SettingsCubit(sl<SettingsService>()));
  sl.registerLazySingleton(() => ThemeCubit());

  // Cubits — factories (fresh instance per widget tree)
  sl.registerFactory(() => AuthCubit(sl<AuthService>()));
  sl.registerFactory(() => ProductsListCubit(sl<ProductsService>()));
  sl.registerFactory(() => ProductDetailCubit(sl<ProductsService>()));
  sl.registerFactory(() => ProductFormCubit(sl<ProductsService>()));
  sl.registerFactory(() => CategoriesCubit(sl<CategoriesService>()));
  sl.registerFactory(() => CategoryFormCubit(sl<CategoriesService>()));
  sl.registerFactory(() => StorefrontCubit(sl<StorefrontService>()));
  sl.registerFactory(() => CheckoutCubit(sl<StorefrontService>()));
  sl.registerFactory(() => OrdersListCubit(sl<OrdersService>()));
  sl.registerFactory(() => OrderDetailCubit(sl<OrdersService>()));
  sl.registerFactory(() => SocialLinksCubit(sl<SettingsService>(),
      settingsCubit: sl<SettingsCubit>()));
}
