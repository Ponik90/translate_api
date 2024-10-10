import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:translate_api_app/screen/home/model/home_model.dart';

class ApiHelper {
  static ApiHelper apiHelper = ApiHelper._();

  ApiHelper._();

  Future<TranslateModel?> postApi({String? source, String? target,String? text}) async {
    String translateLink =
        "https://text-translator2.p.rapidapi.com/translate";

    var response = await http.post(Uri.parse(translateLink), headers: {
      "x-rapidapi-host": "text-translator2.p.rapidapi.com",
      "x-rapidapi-key": "fe6e9f38fbmsh2178b2569ba87bbp1f23f5jsnef8e7376e3a9"
    }, body: {
      "source_language": "$source",
      "target_language": "$target",
      "text": "$text",
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      TranslateModel model = TranslateModel.mapToModel(json);
      return model;
    }
    return null;
  }

  Future<GetData?> getAApi() async {
    String link =  "https://text-translator2.p.rapidapi.com/getLanguages";
    var response = await http.get(Uri.parse(link), headers: {
      "x-rapidapi-host": "text-translator2.p.rapidapi.com",
      "x-rapidapi-key": "fe6e9f38fbmsh2178b2569ba87bbp1f23f5jsnef8e7376e3a9",
    });

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      GetData model = GetData.mapToModel(json);
      return model;
    }
    return null;
  }
}
