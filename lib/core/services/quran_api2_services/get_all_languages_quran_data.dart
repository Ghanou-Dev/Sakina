import 'package:sakina/core/apis/http_consumer.dart';
import 'package:sakina/features/home/models/languages_qurane_data.dart';

class GetAllLanguagesQuranData {
  static Future<List<LanguagesQuraneData>> getAllData() async {
    final String url = 'https://mp3quran.net/api/v3/languages';
    final jsonData = await HttpConsumer.get(url: url, keyMap: 'language');
    final List<LanguagesQuraneData> allLanguages = (jsonData as List<dynamic>)
        .map((language) => LanguagesQuraneData.fromJson(language))
        .toList();
    return allLanguages;
  }
}
