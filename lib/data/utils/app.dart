import 'package:diplome_dima/data/utils/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class App {
  static const String appName = "Skoda";
  static String platform = defaultTargetPlatform.name;

  static const appPadding = EdgeInsets.only(
    right: 20, left: 20, top: 32
  );

  static setupBar(bool isLight) => SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
      statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
      statusBarColor: isLight ? const Color(0x00000000) : Colors.transparent,
      systemNavigationBarColor: isLight ? colorLight : colorDark,
    ),
  );
}
