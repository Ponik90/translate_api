import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:translate_api_app/screen/bottom/controller/bottom_controller.dart';
import 'package:translate_api_app/screen/favourite/view/favourite_screen.dart';
import 'package:translate_api_app/screen/history/view/history_screen.dart';
import 'package:translate_api_app/screen/home/view/home_screen.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({super.key});

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen>
    with TickerProviderStateMixin {
  MotionTabBarController? motionTabBarController;

  BottomController controller = Get.put(BottomController());

  List screen = [
    const HomeScreen(),
    const HistoryScreen(),
    const FavouriteScreen(),
  ];

  @override
  void initState() {
    super.initState();

    motionTabBarController = MotionTabBarController(
        initialIndex: controller.selectIndex.value, length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: screen[controller.selectIndex.value],
        bottomNavigationBar: MotionTabBar(
          initialSelectedTab: "Translate",
          labels: const ["Translate", "History", "Favourite"],
          icons: const [Icons.translate, Icons.history, Icons.star_border],
          tabSize: 50,
          tabBarHeight: 55,
          onTabItemSelected: (value) {
            controller.selectIndex.value = value;
          },
          tabBarColor: const Color(0xfff0e9f6),
          tabIconSelectedColor: Colors.white,
          tabSelectedColor: const Color(0xff003366),

        ),
      ),
    );
  }

  @override
  void dispose() {
    motionTabBarController!.dispose();
    super.dispose();
  }
}
