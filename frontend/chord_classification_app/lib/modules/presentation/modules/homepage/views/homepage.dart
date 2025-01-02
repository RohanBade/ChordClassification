import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import '../../../../../core/extensions/extensions.dart';
import '../../../../../core/utils/app_icons.dart';
import '../../../widgets/buttons/icon_buttons.dart';
import '../../chord_prediction/view/prediction_homescreen.dart';
import 'settings.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final screens = [PredictionHomescreen(), SettingsPage()];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: screens[selectedIndex],
      bottomNavBar: PlatformNavBar(
        currentIndex: selectedIndex,
        itemChanged: (p0) {
          setState(() {
            selectedIndex = p0;
          });
        },
        material: (context, platform) => MaterialNavBarData(
            showUnselectedLabels: false,
            height: 42.ht,
            selectedFontSize: 10.st,
            showSelectedLabels: true,
            elevation: 0),
        items: [
          BottomNavigationBarItem(
              icon: AppIcon(AppIcons.home, size: 20.st), label: "Home"),
          BottomNavigationBarItem(
              icon: AppIcon(AppIcons.setting, size: 20.st), label: "Settings")
        ],
      ),
    );
  }
}
