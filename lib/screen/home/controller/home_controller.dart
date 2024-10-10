import 'package:get/get.dart';
import 'package:translate_api_app/screen/home/model/home_model.dart';
import 'package:translate_api_app/utils/helper/api_helper.dart';
import 'package:translate_api_app/utils/helper/shared_helper.dart';

class HomeController {
  Rx<TranslateModel?> model = TranslateModel().obs;
  Future<GetData?>? dataList;
  RxnString selectSource = RxnString("en");
  RxnString selectTarget = RxnString("hi");
  RxInt sourceIndex = 21.obs;
  RxInt targetIndex = 37.obs;
  RxList<String> searchList = <String>[].obs;
  RxList<String> favouriteList = <String>[].obs;

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
}
