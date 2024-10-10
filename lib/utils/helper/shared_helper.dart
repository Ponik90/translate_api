import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  static SharedHelper sharedHelper = SharedHelper._();

  SharedHelper._();

  Future<void> setHistory(List<String> search) async {
    SharedPreferences shr = await SharedPreferences.getInstance();

    await shr.setStringList('search', search);
  }

  Future<List<String>?> getHistory() async {
    List<String>? data;
    SharedPreferences shr = await SharedPreferences.getInstance();

    data = shr.getStringList('search');
    return data;
  }

  Future<void> setFavourite(List<String> fav) async {
    SharedPreferences shr = await SharedPreferences.getInstance();

    await shr.setStringList('fav', fav);
  }

  Future<List<String>?> getFavourite() async {
    List<String>? data;
    SharedPreferences shr = await SharedPreferences.getInstance();

    data = shr.getStringList('fav');
    return data;
  }
}
