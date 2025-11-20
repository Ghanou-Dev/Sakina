import 'package:sakina/helpers/api.dart';
import 'package:sakina/errors/internet_exceptions.dart';
import 'package:sakina/models/reciter_chikh_model.dart';

class GetAllReciers {
  static Future<List<ReciterChikhModel>> getReciters() async {
    // يمكن طلبه بعد جلب البيانات جميع اللغات
    final String url = 'https://www.mp3quran.net/api/v3/reciters?language=ar';
    try {
      final jsonData = await Api.get(url: url, keyMap: 'reciters');
      List<ReciterChikhModel> allReciters = (jsonData as List<dynamic>)
          .map((reciter) => ReciterChikhModel.fromJson(reciter))
          .toList();
      return allReciters;
    } on InternetTimeoutEception catch (e) {
      throw InternetTimeoutEception(message: e.message);
    } on NoInternetException catch (e) {
      throw NoInternetException(message: e.message);
    } catch (e) {
      throw InternetTimeoutEception(message: 'Timeout Exception');
    }
  }
}
