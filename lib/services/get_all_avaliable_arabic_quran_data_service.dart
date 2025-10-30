import 'package:sakina/helpers/api.dart';
import 'package:sakina/models/chikh_model.dart';

class GetAllAvaliableArabicQuranDataService {
  // get all availabel data
  static Future<List<ChikhModel>> getAllData({
    required String format,
    required String language,
    required String type,
  }) async {
    String url =
        'http://api.alquran.cloud/v1/edition?format=$format&language=$language&type=$type';

    final data = await Api.get(url: url, keyMap: "data");
    List<ChikhModel> listChikhes = (data as List<dynamic>)
        .map((d) => ChikhModel.fromJson(d))
        .toList();
    return listChikhes;
  }
}
