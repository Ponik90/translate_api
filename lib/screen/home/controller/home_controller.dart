import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:translate_api_app/screen/home/model/home_model.dart';
import 'package:translate_api_app/utils/helper/api_helper.dart';
import 'package:translate_api_app/utils/helper/shared_helper.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeController extends GetxController {
  Rx<TranslateModel?> model = TranslateModel().obs;
  Future<GetData?>? dataList;
  RxnString selectSource = RxnString("en");
  RxnString selectTarget = RxnString("hi");
  RxInt sourceIndex = 21.obs;
  RxInt targetIndex = 37.obs;
  RxList<String> searchList = <String>[].obs;
  RxList<String> favouriteList = <String>[].obs;
  stt.SpeechToText? speechToText = stt.SpeechToText();

  RxBool listen = false.obs;
  RxBool micOn = false.obs;
  RxString text = "".obs;

  Future<void> translateData({String? text}) async {
    model.value = await ApiHelper.apiHelper.postApi(
        source: selectSource.value, target: selectTarget.value, text: text);
  }

  void getSupportLanguage() {
    dataList = ApiHelper.apiHelper.getAApi();
  }

  Future<void> setSearchData(String search) async {
    List<String>? data = await SharedHelper.sharedHelper.getHistory();

    if (data != null) {
      data.add(search);
      SharedHelper.sharedHelper.setHistory(data);
    } else {
      SharedHelper.sharedHelper.setHistory([search]);
    }

    getSearchData();
  }

  Future<void> getSearchData() async {
    var list = await SharedHelper.sharedHelper.getHistory();

    if (list != null) {
      searchList.value = list;
    }
  }

  Future<void> setFavouriteData(String fav) async {
    List<String>? data = await SharedHelper.sharedHelper.getFavourite();
    if (data != null) {
      data.add(fav);
      SharedHelper.sharedHelper.setFavourite(data);
    } else {
      SharedHelper.sharedHelper.setFavourite([fav]);
    }

    getFavouriteData();
  }

  Future<void> getFavouriteData() async {
    var list = await SharedHelper.sharedHelper.getFavourite();

    if (list != null) {
      favouriteList.value = list;
    }
  }

  Future<void> initializedSpeech() async {
    listen.value = await speechToText!.initialize();
  }

  Future<void> startListen() async {
    await speechToText!.listen(
      onResult: (result) {
        text.value = result.recognizedWords;
      },
    );
    print("========4=======${micOn.value}");
    print("===========5========${text.value}");
    micOn.value = true;
  }

  // void speechResult(SpeechRecognitionResult result) {
  //   text.value = result.recognizedWords;
  //
  //   print("========4=======${micOn.value}");
  //   print("===========5========${text.value}");
  // }

  Future<void> stopListen() async {
    await speechToText!.stop();
    micOn.value = false;
    print("========6=======${micOn.value}");
  }
}
