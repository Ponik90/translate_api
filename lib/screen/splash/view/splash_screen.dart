import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 4),
      () {
        Get.offNamed('home');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment(-5, -1.5),
            child: Opacity(
              opacity: 0.5,
              child: CircleAvatar(
                radius: 200,
                backgroundColor: Color(0xff007AF5),
              ),
            ),
          ),
          const Align(
            alignment: Alignment(7, -1.7),
            child: Opacity(
              opacity: 0.5,
              child: CircleAvatar(
                radius: 200,
                backgroundColor: Color(0xffF28739),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/image/translate.jpg",
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "TRANSLATE ON THE GO",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                LoadingAnimationWidget.flickr(
                  leftDotColor: const Color(0Xff6E93B6),
                  rightDotColor: const Color(0xffBDE0E6),
                  size: 40,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
