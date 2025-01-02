//Centralization of icons

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../services/get.dart';

abstract class AppIcons {
  static const account = Icons.account_circle_outlined;
  static const email = Icons.email_outlined;

  static const play = Icons.play_arrow_rounded;
  static const pause = Icons.pause_circle;

  static const reload = Icons.replay;

  static const home = CupertinoIcons.home;
  static get setting => PlatformIcons(Get.context).settings;
}
