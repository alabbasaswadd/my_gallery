import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_gallery/core/di/service_locator.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/features/cart/domain/cart_cubit.dart';
import 'package:my_gallery/features/categories/data/categories_service.dart';
import 'package:my_gallery/features/categories/domain/categories_cubit.dart';
import 'package:my_gallery/features/categories/presentation/screens/categories_screen.dart';
import 'package:my_gallery/features/orders/data/orders_service.dart';
import 'package:my_gallery/features/orders/domain/orders_list_cubit.dart';
import 'package:my_gallery/features/orders/presentation/screens/orders_screen.dart';
import 'package:my_gallery/features/products/data/products_service.dart';
import 'package:my_gallery/features/products/domain/products_list_cubit.dart';
import 'package:my_gallery/features/products/presentation/screens/products_screen.dart';
import 'package:my_gallery/features/profile/presentation/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _tabs = const [
    _TabInfo(Icons.inventory_2_outlined, Icons.inventory_2, 'المنتجات'),
    _TabInfo(Icons.category_outlined, Icons.category, 'الفئات'),
    _TabInfo(Icons.receipt_long_outlined, Icons.receipt_long, 'الطلبات'),
    _TabInfo(Icons.person_outline, Icons.person, 'الحساب'),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final shopName = authState is AuthAuthenticated
        ? authState.user.shopName
        : context.read<SettingsCubit>().currentOrDefault.brandName;
    final role = authState is AuthAuthenticated ? authState.user.role : '';

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductsListCubit(sl<ProductsService>()),
        ),
        BlocProvider(
          create: (_) => CategoriesCubit(sl<CategoriesService>()),
        ),
        BlocProvider(
          create: (_) => OrdersListCubit(sl<OrdersService>()),
        ),
        BlocProvider.value(value: sl<CartCubit>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [
              Text(shopName,
                  style: Theme.of(context).textTheme.titleLarge),
              if (role.isNotEmpty)
                Text(
                  _roleLabel(role),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.8),
                      ),
                ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.storefront_outlined),
              tooltip: 'المتجر',
              onPressed: () => context.push('/storefront'),
            ),
          ],
        ),
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            ProductsScreen(),
            CategoriesScreen(),
            OrdersScreen(),
            ProfileScreen(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          items: _tabs.map((tab) {
            return BottomNavigationBarItem(
              icon: Icon(tab.icon),
              activeIcon: Icon(tab.activeIcon),
              label: tab.label,
            );
          }).toList(),
        ),
      ),
    );
  }

  String _roleLabel(String role) => switch (role) {
        'Owner' => 'مالك',
        'Manager' => 'مدير',
        'Employee' => 'موظف',
        _ => role,
      };
}

class _TabInfo {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _TabInfo(this.icon, this.activeIcon, this.label);
}
