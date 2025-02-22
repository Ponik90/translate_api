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
        Get.offNamed('bottom');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: MediaQuery.sizeOf(context).width / -4.5,
            bottom: MediaQuery.sizeOf(context).height / 1.4,
            child: const Opacity(
              opacity: 0.5,
              child: CircleAvatar(
                radius: 200,
                backgroundColor: Color(0xff007AF5),
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.sizeOf(context).width / 2.5,
            bottom: MediaQuery.sizeOf(context).height / 1.3,
            child: const Opacity(
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
              ],
            ),
          ),
          Align(
            alignment: const Alignment(0, 0.8),
            child: LoadingAnimationWidget.flickr(
              leftDotColor: const Color(0Xff6E93B6),
              rightDotColor: const Color(0xffBDE0E6),
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
