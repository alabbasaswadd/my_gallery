import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_gallery/core/config/app_config.dart';
import 'package:my_gallery/core/di/service_locator.dart';
import 'package:my_gallery/features/settings/data/models/settings_models.dart';
import 'package:my_gallery/features/settings/domain/settings_cubit.dart';
import 'package:my_gallery/features/settings/domain/theme_cubit.dart';
import 'package:my_gallery/routes.dart';
import 'package:my_gallery/theme.dart' show AppTheme, activePalette;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  // Load persisted theme and cached settings before the first frame.
  await Future.wait([
    sl<ThemeCubit>().load(),
    sl<SettingsCubit>().load(AppConfig.shopId),
  ]);
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
      child: BlocBuilder<ThemeCubit, ThemeSettings>(
        builder: (context, themeSettings) {
          return BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, settingsState) {
              final settings = settingsState is SettingsLoaded
                  ? settingsState.settings
                  : kDefaultSettings;
              final palette = activePalette(settings, themeSettings.source);
              return ScreenUtilInit(
                designSize: const Size(390, 844),
                minTextAdapt: true,
                builder: (_, __) => MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  title: settings.brandName,
                  theme: AppTheme.build(Brightness.light, palette),
                  darkTheme: AppTheme.build(Brightness.dark, palette),
                  themeMode: themeSettings.mode,
                  routerConfig: router,
                  locale: const Locale('ar'),
                  supportedLocales: const [Locale('ar'), Locale('en')],
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  builder: (context, child) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: child!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
