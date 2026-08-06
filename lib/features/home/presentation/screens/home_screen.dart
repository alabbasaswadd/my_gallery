import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/core/di/service_locator.dart';
import 'package:my_gallery/features/auth/domain/auth_cubit.dart';
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
  void initState() {
    super.initState();
    // When the app starts with a valid session the GoRouter redirect goes
    // directly to /home without mounting LoginScreen, so checkSession() is
    // never called. Trigger it here if the cubit is still in its initial state.
    Future.microtask(() {
      if (mounted) {
        final cubit = context.read<AuthCubit>();
        if (cubit.state is AuthInitial) cubit.checkSession();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
}

class _TabInfo {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _TabInfo(this.icon, this.activeIcon, this.label);
}
