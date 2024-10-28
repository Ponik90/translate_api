import 'package:avatar_glow/avatar_glow.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:translate_api_app/screen/home/controller/home_controller.dart';
import 'package:translate_api_app/screen/home/model/home_model.dart';
import 'package:flutter/services.dart';
import 'package:translate_api_app/utils/helper/Ads_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController txtTranslate = TextEditingController();
  HomeController controller = Get.put(HomeController());
  AdsHelper adsHelper = AdsHelper();

  @override
  void initState() {
    super.initState();
    controller.getSupportLanguage();
    adsHelper.loadBanner();

    // adsHelper.loadInter();
    // adsHelper.loadNative();
    // adsHelper.loadReward();
    // adsHelper.loadAppOpen();

    controller.initializedSpeech();
    controller.initializedText();
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
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  width: MediaQuery.sizeOf(context).width,
                  child: AdWidget(ad: adsHelper.bannerAd!),
                ),

                Container(
                  height: 50,
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xfff0e9f6),
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
                    color: const Color(0xfff0e9f6),
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
                          IconButton(
                            onPressed: () {
                              txtTranslate.text.isEmpty
                                  ? CherryToast.warning(
                                      title:
                                          const Text("Please enter the text"),
                                      action: const Text("Can't copy"),
                                    ).show(context)
                                  : controller.flutterTts.speak(
                                      txtTranslate.text,
                                    );
                            },
                            icon: const Icon(
                              Icons.volume_up_outlined,
                              size: 30,
                              color: Color(0xff003366),
                            ),
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
                      Obx(
                        () {
                          txtTranslate.text = controller.text.value;

                          return TextFormField(
                            controller: txtTranslate,
                            style: const TextStyle(fontSize: 20),
                            maxLines: 5,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                              hintText: "Enter text here !!!",
                              filled: true,
                              fillColor: Color(0xfff0e9f6),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => AvatarGlow(
                              startDelay: const Duration(milliseconds: 1000),
                              
                              glowShape: BoxShape.circle,
                              animate: controller.micOn.value,
                              glowColor: const Color(0xff003366),
                              repeat: true,
                              child: IconButton.filled(
                                iconSize: 24,
                                style: IconButton.styleFrom(
                                  backgroundColor: const Color(0xff003366),
                                ),
                                onPressed: () {
                                  controller.speechToText!.isNotListening
                                      ? controller.startListen()
                                      : controller.stopListen();
                                },
                                icon: const Icon(
                                  Icons.mic_outlined,
                                  color: Colors.white,
                                ),
                              ),
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
                                CherryToast.warning(
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
                          color: const Color(0xfff0e9f6),
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
                                    controller.model.value!.model == null
                                        ? CherryToast.warning(
                                            title: const Text(
                                                "Please enter the text"),
                                            action: const Text("Can't copy"),
                                          ).show(context)
                                        : Clipboard.setData(
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
                                    controller.model.value!.model == null
                                        ? CherryToast.warning(
                                            title: const Text(
                                                "Please enter the text"),
                                            action: const Text("Can't share"),
                                          ).show(context)
                                        : Share.share(
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
                                    controller.model.value!.model == null
                                        ? CherryToast.warning(
                                            title: const Text(
                                                "Please enter the text"),
                                          ).show(context)
                                        : controller.setFavouriteData(controller
                                            .model.value!.model!.translate!);
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
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     if (adsHelper.interstitialAd != null) {
                //       adsHelper.interstitialAd!.show();
                //     }
                //
                //     adsHelper.interstitialAd!.fullScreenContentCallback =
                //         FullScreenContentCallback(
                //       onAdClicked: (ad) {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const FavouriteScreen(),
                //           ),
                //         );
                //       },
                //       onAdFailedToShowFullScreenContent: (ad, error) {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const FavouriteScreen(),
                //           ),
                //         );
                //       },
                //     );
                //     adsHelper.loadInter();
                //   },
                //   child: const Text("Inter"),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     if (adsHelper.rewardedAd != null) {
                //       adsHelper.rewardedAd!.show(
                //         onUserEarnedReward: (ad, reward) {
                //           ScaffoldMessenger.of(context).showSnackBar(
                //             SnackBar(
                //               content: Text("${reward.amount}"),
                //             ),
                //           );
                //         },
                //       );
                //     }
                //
                //     adsHelper.rewardedAd!.fullScreenContentCallback =
                //         FullScreenContentCallback(
                //       onAdClicked: (ad) {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const FavouriteScreen(),
                //           ),
                //         );
                //       },
                //       onAdFailedToShowFullScreenContent: (ad, error) {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const FavouriteScreen(),
                //           ),
                //         );
                //       },
                //     );
                //
                //     adsHelper.loadReward();
                //   },
                //   child: const Text("Reward"),
                // ),
                // ElevatedButton(
                //   onPressed: () {
                //     if (adsHelper.appOpenAd != null) {
                //       adsHelper.appOpenAd!.show();
                //     }
                //
                //     adsHelper.appOpenAd!.fullScreenContentCallback =
                //         FullScreenContentCallback(
                //       onAdClicked: (ad) {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const FavouriteScreen(),
                //           ),
                //         );
                //       },
                //       onAdFailedToShowFullScreenContent: (ad, error) {
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) => const FavouriteScreen(),
                //           ),
                //         );
                //       },
                //     );
                //     adsHelper.loadAppOpen();
                //   },
                //   child: const Text("App open"),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sourceSheet(GetData model) {
    showModalBottomSheet(
      backgroundColor: const Color(0xffeddef3),
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
                  color: const Color(0xff245e9e),
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
                    color: Colors.white,
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
      backgroundColor: const Color(0xffeddef3),
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
                  color: const Color(0xff245e9e),
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
                    color: Colors.white,
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
