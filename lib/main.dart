import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:translate_api_app/utils/app_routes.dart';
import 'package:translate_api_app/utils/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: screen,
      theme: lightTheme,
    ),
  );
}
