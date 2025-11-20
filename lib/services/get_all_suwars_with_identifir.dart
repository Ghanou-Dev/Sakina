import 'package:sakina/helpers/api.dart';
import 'package:sakina/errors/internet_exceptions.dart';
import 'package:sakina/models/surah_model.dart';

class GetAllSuwarsWithIdentifir {
  static Future<List<SurahModel>> call({required String identifir}) async {
    try {
      final String url = 'http://api.alquran.cloud/v1/quran/$identifir';
      final response = await Api.get(url: url, keyMap: "data");
      List<SurahModel> suwars = (response['surahs'] as List<dynamic>)
          .map((surah) => SurahModel.fromJson(surah))
          .toList();
      return suwars;
    } on InternetTimeoutEception catch (e) {
      throw InternetTimeoutEception(message: e.message);
    } on NoInternetException catch (e) {
      throw NoInternetException(message: e.message);
    } catch (e) {
      throw InternetTimeoutEception(message: 'Timeout Exception');
    }
  }
}
