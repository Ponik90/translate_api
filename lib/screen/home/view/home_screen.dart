import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translate_api_app/screen/home/controller/home_controller.dart';
import 'package:translate_api_app/screen/home/model/home_model.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtTranslate = TextEditingController();
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getSupportLanguage();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: const Color(0xff003366),
          title: const Text(
            "Translator App",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed("history");
              },
              icon: const Icon(
                Icons.history,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Get.toNamed("fav");
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xffeddef3),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        offset: const Offset(1, 2),
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                        future: controller.dataList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else if (snapshot.hasData) {
                            GetData? model = snapshot.data;

                            return TextButton(
                              onPressed: () {
                                sourceSheet(model!);
                              },
                              child: Obx(
                                () => Text(
                                  "${model!.model!.model![controller.sourceIndex.value].name}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }
                          return const CircleAvatar();
                        },
                      ),
                      const Icon(Icons.swap_horiz),
                      FutureBuilder(
                        future: controller.dataList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else if (snapshot.hasData) {
                            GetData? model = snapshot.data;

                            return TextButton(
                              onPressed: () {
                                targetSheet(model!);
                              },
                              child: Obx(
                                () => Text(
                                  "${model!.model!.model![controller.targetIndex.value].name}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            );
                          }
                          return const CircleAvatar();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 300,
                  width: MediaQuery.sizeOf(context).width,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xffeddef3),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        spreadRadius: 1,
                        offset: const Offset(1, 2),
                        blurStyle: BlurStyle.normal,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          FutureBuilder(
                            future: controller.dataList,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              } else if (snapshot.hasData) {
                                GetData? model = snapshot.data;
                                return Obx(
                                  () => Text(
                                    "${model!.model!.model![controller.sourceIndex.value].name}",
                                    style: const TextStyle(
                                      color: Color(0xff003366),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                );
                              }
                              return const Text("");
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.volume_up_outlined,
                            size: 30,
                            color: Color(0xff003366),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(
                              Icons.close_outlined,
                              size: 30,
                              color: Color(0xff003366),
                            ),
                            onPressed: () {
                              txtTranslate.clear();
                            },
                          ),
                        ],
                      ),
                      TextFormField(
                        controller: txtTranslate,
                        style: const TextStyle(fontSize: 20),
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          hintText: "Enter text here !!!",
                          filled: true,
                          fillColor: Color(0xffeddef3),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton.filled(
                            iconSize: 24,
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xff003366),
                            ),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mic_outlined,
                              color: Colors.white,
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffFF6600),
                            ),
                            onPressed: () {
                              if (txtTranslate.text.isNotEmpty) {
                                controller.translateData(
                                    text: txtTranslate.text);
                                controller.setSearchData(txtTranslate.text);
                                FocusManager.instance.primaryFocus!.unfocus();
                              } else {
                                CherryToast.error(
                                  animationType: AnimationType.fromTop,
                                  title: const Text("Please enter the"),
                                  action: const Text("Text"),
                                ).show(context);
                              }
                            },
                            child: const Text(
                              "Translate",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: controller.dataList,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("${snapshot.hasError}");
                    } else if (snapshot.hasData) {
                      GetData? data = snapshot.data;
                      return Container(
                        height: 300,
                        width: MediaQuery.sizeOf(context).width,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xffeddef3),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              offset: const Offset(1, 2),
                              blurStyle: BlurStyle.normal,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                "${data!.model!.model![controller.targetIndex.value].name}",
                                style: const TextStyle(
                                  color: Color(0xff003366),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => controller.model.value!.model == null
                                  ? const Text(
                                      "translated text show here !!",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    )
                                  : Text(
                                      "${controller.model.value!.model!.translate}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(
                                          text:
                                              "${controller.model.value!.model!.translate}"),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.copy_rounded,
                                    size: 30,
                                    color: Color(0xff003366),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Share.share(
                                        "${controller.model.value!.model!.translate}");
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    size: 30,
                                    color: Color(0xff003366),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.setFavouriteData(controller.model.value!.model!.translate!);
                                  },
                                  icon: const Icon(
                                    Icons.star_border,
                                    size: 30,
                                    color: Color(0xff003366),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    }

                    return Container(
                      height: 300,
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.all(8),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xffeddef3),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade400,
                            spreadRadius: 1,
                            offset: const Offset(1, 2),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                      ),
                      child: const CircularProgressIndicator(),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sourceSheet(GetData model) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GridView.builder(
          itemCount: model.model!.model!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.sourceIndex.value = index;
                controller.selectSource.value = model.model!.model![index].code;
                Get.back();
              },
              child: Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xff80BCFA),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 1,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Text(
                  "${model.model!.model![index].name}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void targetSheet(GetData model) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return GridView.builder(
          itemCount: model.model!.model!.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.targetIndex.value = index;
                controller.selectTarget.value = model.model!.model![index].code;
                Get.back();
              },
              child: Container(
                alignment: AlignmentDirectional.center,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: const Color(0xff80BCFA),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade600,
                      spreadRadius: 1,
                      offset: const Offset(1, 1),
                    ),
                  ],
                ),
                child: Text(
                  "${model.model!.model![index].name}",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
