import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:translate_api_app/screen/home/model/home_model.dart';
import 'package:translate_api_app/utils/helper/connectivity_helper.dart';

class ApiHelper {
  static ApiHelper apiHelper = ApiHelper._();

  final dio = Dio();

  ApiHelper._();

  Future<TranslateModel?> postApi(
      {String? source, String? target, String? text}) async {
    String translateLink = "https://text-translator2.p.rapidapi.com/translate";

    var data = FormData.fromMap({
      "source_language": "$source",
      "target_language": "$target",
      "text": "$text",
    });

    var response = await dio.post(translateLink,
        options: Options(
          headers: {
            "x-rapidapi-host": "text-translator2.p.rapidapi.com",
            "x-rapidapi-key":
                "fe6e9f38fbmsh2178b2569ba87bbp1f23f5jsnef8e7376e3a9"
          },
        ),
        data: data);

    if (response.statusCode == 200) {
      TranslateModel model = TranslateModel.mapToModel(response.data);
      return model;
    }

    return null;
  }

  Future<GetData?> getAApi() async {
    String link = "https://text-translator2.p.rapidapi.com/getLanguages";

    var response = await dio.get(
      link,
      options: Options(
        headers: {
          "x-rapidapi-host": "text-translator2.p.rapidapi.com",
          "x-rapidapi-key": "fe6e9f38fbmsh2178b2569ba87bbp1f23f5jsnef8e7376e3a9"
        },
      ),
    );

    if (response.statusCode == 200) {
      GetData model = GetData.mapToModel(response.data);
      return model;
    }
    return null;
  }
}
