class TranslateModel {
  DataModel? model;

  TranslateModel({this.model});

  factory TranslateModel.mapToModel(Map m1) {
    return TranslateModel(
      model: DataModel.mapToModel(
        m1['data'],
      ),
    );
  }
}

class DataModel {
  String? translate;

  DataModel({this.translate});

  factory DataModel.mapToModel(Map m1) {
    return DataModel(translate: m1['translatedText']);
  }
}

class GetData {
  GetTranslate? model;

  GetData({this.model});

  factory GetData.mapToModel(Map m1) {
    return GetData(model: GetTranslate.mapToModel(m1['data']));
  }
}

class GetTranslate {
  List<Language>? model;

  GetTranslate({this.model});

  factory GetTranslate.mapToModel(Map m1) {
    List data = m1['languages'];
    return GetTranslate(
      model: data
          .map(
            (e) => Language.mapToModel(e as Map),
          )
          .toList(),
    );
  }
}

class Language {
  String? code, name;

  Language({this.name, this.code});

  factory Language.mapToModel(Map m1) {
    return Language(
      name: m1['name'],
      code: m1['code'],
    );
  }
}
