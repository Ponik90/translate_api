import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controller/home_controller.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getFavouriteData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Translate"),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => ListView.builder(
          itemCount: controller.favouriteList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.favouriteList[index]),
            );
          },
        ),
      ),
    );
  }
}
