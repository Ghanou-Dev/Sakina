import 'package:sakina/helpers/api.dart';
import 'package:sakina/models/languages_qurane_data.dart';

class GetAllLanguagesQuranData {
  static Future<List<LanguagesQuraneData>> getAllData() async {
    final String url = 'https://mp3quran.net/api/v3/languages';
    final jsonData = await Api.get(url: url, keyMap: 'language');
    final List<LanguagesQuraneData> allLanguages = (jsonData as List<dynamic>)
        .map((language) => LanguagesQuraneData.fromJson(language))
        .toList();
    return allLanguages;
  }
}
