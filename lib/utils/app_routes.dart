import 'package:flutter/material.dart';
import 'package:translate_api_app/screen/bottom/view/bottom_screen.dart';
import 'package:translate_api_app/screen/splash/view/splash_screen.dart';

Map<String, WidgetBuilder> screen = {
  '/': (context) => const SplashScreen(),
  'bottom': (context) => const BottomScreen()
};
