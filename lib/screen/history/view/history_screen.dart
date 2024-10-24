import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:translate_api_app/screen/home/controller/home_controller.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getSearchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your search history"),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => ListView.builder(
          itemCount: controller.searchList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(controller.searchList[index]),
            );
          },
        ),
      ),
    );
  }
}
