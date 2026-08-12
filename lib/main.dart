import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/core/di/service_locator.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/features/settings/domain/theme_cubit.dart';
import 'package:my_gallery/firebase_options.dart';
import 'package:my_gallery/l10n/app_localizations.dart';
import 'package:my_gallery/routes.dart';
import 'package:my_gallery/shared/widgets/network_status_listener.dart';
import 'package:my_gallery/theme.dart' show AppTheme, activePalette;

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // Keep the native splash visible while the app initializes.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await setupServiceLocator();
  // Run all startup I/O in parallel: theme, settings, and routing decisions.
  // primeRouterStartupState() caches onboarding + session so the first
  // GoRouter redirect evaluation has no async I/O, preventing a blank Flutter
  // frame between the native splash and the home screen.
  await Future.wait([
    sl<ThemeCubit>().load(),
    sl<SettingsCubit>().load(AppConfig.shopId),
    primeRouterStartupState(),
  ]);

  // Remove the splash only after Flutter has painted its first frame, so
  // there is no visible gap between the native splash and the Flutter UI.
  widgetsBinding.addPostFrameCallback((_) => FlutterNativeSplash.remove());

  runApp(const MyGalleryApp());
}

class MyGalleryApp extends StatelessWidget {
  const MyGalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: sl<SettingsCubit>()),
        BlocProvider.value(value: sl<ThemeCubit>()),
      ],
      // ScreenUtilInit sits outside the BlocBuilders so that theme/settings
      // changes do not trigger a ScreenUtil re-initialization.
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        builder: (_, __) => BlocBuilder<ThemeCubit, ThemeSettings>(
          builder: (context, themeSettings) {
            return BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, settingsState) {
                final settings = settingsState is SettingsLoaded
                    ? settingsState.settings
                    : kDefaultSettings;
                final palette = activePalette(settings, themeSettings.source);
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: settings.brandName,
                  theme: AppTheme.build(Brightness.light, palette),
                  darkTheme: AppTheme.build(Brightness.dark, palette),
                  themeMode: themeSettings.mode,
                  routerConfig: router,
                  locale: const Locale('ar'),
                  supportedLocales: AppLocalizations.supportedLocales,
                  localizationsDelegates:
                      AppLocalizations.localizationsDelegates,
                  builder: (context, child) => Directionality(
                    textDirection: TextDirection.rtl,
                    // Surfaces throttled unstable/restored connectivity banners
                    // app-wide, without blocking any screen.
                    child: NetworkStatusListener(
                      child: child ?? const SizedBox.shrink(),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
