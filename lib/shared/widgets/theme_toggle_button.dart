import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_gallery/features/settings/domain/theme_cubit.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeCubit>().state == ThemeMode.dark;
    return IconButton(
      tooltip: isDark ? 'تفعيل الوضع الفاتح' : 'تفعيل الوضع الداكن',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(isDark),
        ),
      ),
      onPressed: () => context.read<ThemeCubit>().setMode(
            isDark ? ThemeMode.light : ThemeMode.dark,
          ),
    );
  }
}
