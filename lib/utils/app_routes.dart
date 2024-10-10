import 'package:flutter/material.dart';
import 'package:translate_api_app/screen/favourite/view/favourite_screen.dart';
import 'package:translate_api_app/screen/history/view/history_screen.dart';
import 'package:translate_api_app/screen/home/view/home_screen.dart';
import 'package:translate_api_app/screen/splash/view/splash_screen.dart';

Map<String, WidgetBuilder> screen = {
  '/': (context) => const SplashScreen(),
  'home': (context) => const HomeScreen(),
  'history': (context) => const HistoryScreen(),
  'fav': (context) => const FavouriteScreen(),
};
