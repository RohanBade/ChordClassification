import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../abstractservices/platform_provider.dart';
import '../../../../../core/configs/app_colors.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/services/get.dart';
import '../../../../injection_container.dart';
import '../../../widgets/buttons/app_buttons.dart';
import '../../../widgets/listtile/app_list_tile.dart';
import '../../../widgets/text/app_text.dart';
import '../../auth/view/login_page.dart';
import '../../chord_prediction/providers/music_notifier_provider.dart';
import '../../splash_screen/view/splash_screen.dart';
import '../widgets/setting_listtile.dart';
import 'base_url_change_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(title: AppText("Settings")),
      body: Padding(
        padding: 8.horizontalPad,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Consumer(builder: (context, ref, child) {
            final baseUrl = ref.watch(baseUrlProvider);
            return AppListTile(
              title: AppText("BaseUrl"),
              trailing: AppText(baseUrl.replaceAll("http://", ''),
                  style: Get.bodySmall.px10.primary),
              onTap: () => Get.to(BaseUrlChangeView()),
            );
          }),
          ValueListenableBuilder(
              valueListenable: platformProvider,
              builder: (context, platform, child) => AppSwitchListTile(
                    title: "Enable Ios View",
                    value: platform == PlatformStyle.Cupertino,
                    onChanged: (p0) {
                      if (p0) {
                        platformProvider.value = PlatformStyle.Cupertino;
                        Get.toast("Ios View");
                        return;
                      }
                      platformProvider.value = PlatformStyle.Material;
                      Get.toast("Android View");
                      return;
                    },
                  )),
          Consumer(
            builder: (_, WidgetRef ref, __) {
              final themeNotifier = ref.watch(themeNotifierProvider);
              return AppSwitchListTile(
                  title: themeNotifier.isDark
                      ? "Disable Dark mode"
                      : "Enable Dark mode",
                  value: themeNotifier.isDark,
                  onChanged: (p0) => themeNotifier.toggleTheme());
            },
          ),
          Spacer(),
          Consumer(
            builder: (context, ref, child) {
              final hasLogin = ref.watch(tokenManagerProvider).token != null;
              return AppButton(
                  onTap: () {
                    ref.invalidate(chordPredictionNotifier);
                    ref.invalidate(musicFileProvider);
                    if (hasLogin) {
                      ref.read(tokenManagerProvider).updateToken(null);
                      Get.offAll(const SplashScreen());
                      return;
                    }
                    Get.to(LoginPage());
                  },
                  text: hasLogin ? "Log Out" : "Log In",
                  buttonColor: hasLogin ? AppColors.red : AppColors.primary);
            },
          )
        ]),
      ),
    );
  }
}
