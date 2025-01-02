import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'abstractservices/platform_provider.dart';
import 'core/configs/app_theme.dart';
import 'core/services/storageservices/token_manager.dart';
import 'core/services/theme_handler/theme_notifier.dart';
import 'modules/injection_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/services/get.dart';
import 'modules/presentation/modules/splash_screen/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  final box = await Get.box.init();
  final tokenManager = await TokenManager(box).init();
  final themeNotifier = await ThemeNotifier(box).init();
  await dotenv.load(fileName: '.env');
  runApp(ProviderScope(overrides: [
    storageServiceProvider.overrideWith((ref) => box),
    tokenManagerProvider.overrideWith((ref) => tokenManager),
    themeNotifierProvider.overrideWith((ref) => themeNotifier),
  ], child: const Core()));
}

class Core extends ConsumerWidget {
  const Core({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider).themeMode;
    return ScreenUtilInit(
        ensureScreenSize: true,
        designSize: const Size(360, 640),
        child: ValueListenableBuilder(
          valueListenable: platformProvider,
          builder: (context, platform, child) => PlatformProvider(
            key: Get.key(platform),
            settings: PlatformSettingsData(
                iosUsesMaterialWidgets: true,
                matchMaterialCaseForPlatformText: false,
                legacyIosUsesMaterialWidgets: true,
                iosUseZeroPaddingForAppbarPlatformIcon: true,
                platformStyle: PlatformStyleData(android: platform)),
            builder: (context) => PlatformTheme(
                key: Get.key(themeMode),
                themeMode: themeMode,
                materialLightTheme: AppThemes.lightTheme,
                materialDarkTheme: AppThemes.darkTheme,
                cupertinoDarkTheme: AppThemes.iosdarkTheme,
                cupertinoLightTheme: AppThemes.ioslightTheme,
                builder: (context) => PlatformApp(
                    debugShowCheckedModeBanner: false,
                    navigatorKey: navigatorKey,
                    scrollBehavior: Get.scrollBehaviour,
                    localizationsDelegates: const <LocalizationsDelegate<
                        dynamic>>[
                      DefaultMaterialLocalizations.delegate,
                      DefaultCupertinoLocalizations.delegate,
                      DefaultWidgetsLocalizations.delegate
                    ],
                    home: const SplashScreen())),
          ),
        ));
  }
}
