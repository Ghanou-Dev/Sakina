import 'package:sakina/core/apis/api_consumer.dart';
import 'package:sakina/features/home/models/taffsir_surah_model.dart';

class GetTaffsirOfQuranService {
  final ApiConsumer api;
  GetTaffsirOfQuranService({
    required this.api,
  });

  Future<List<TaffsirSurahModel>> call() async {
    final response = await api.get(
      'http://api.alquran.cloud/v1/quran/ar.muyassar',
    );
    List<TaffsirSurahModel> taffsir =
        (response['data']['surahs'] as List<dynamic>)
            .map((i) => TaffsirSurahModel.fromJson(i))
            .toList();
    return taffsir;
  }
}
