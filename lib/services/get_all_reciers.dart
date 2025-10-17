import 'package:sakina/helpers/api.dart';
import 'package:sakina/models/reciter_chikh_model.dart';

class GetAllReciers {
  static Future<List<ReciterChikhModel>> getReciters() async {
    // يمكن طلبه بعد جلب البيانات جميع اللغات
    final String url = 'https://www.mp3quran.net/api/v3/reciters?language=ar';
    final jsonData = await Api.get(url: url, keyMap: 'reciters');
    List<ReciterChikhModel> allReciters = (jsonData as List<dynamic>)
        .map((reciter) => ReciterChikhModel.fromJson(reciter))
        .toList();
    return allReciters;
  }
}
