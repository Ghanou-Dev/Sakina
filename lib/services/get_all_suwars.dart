import 'package:sakina/helpers/api.dart';
import 'package:sakina/models/surah_model.dart';

class GetAllSuwars {
  static Future<List<SurahModel>> suwars({required String identifir}) async {
    final String url = 'http://api.alquran.cloud/v1/quran/$identifir';
    final response = await Api.get(url: url, keyMap: "data");
    List<SurahModel> suwars = (response['surahs'] as List<dynamic>)
        .map((surah) => SurahModel.fromJson(surah))
        .toList();
    return suwars;
  }
}
