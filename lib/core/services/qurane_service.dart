import 'dart:convert';
import 'package:sakina/core/apis/api_consumer.dart';
import 'package:sakina/core/apis/api_end_point.dart';
import 'package:sakina/core/dto/surah_dto.dart';

class QuraneService {
  final ApiConsumer api;
  const QuraneService({required this.api});

  Future<List<SurahDto>> fetchAllSuwars() async {
    final List<SurahDto> suwars = [];
    for (int i = 1; i <= 112; i++) {
      final response = await api.get(
        ApiEndPoint.getSpecialSurahInfo(surahNumber: i),
      );
      final jsonData = jsonDecode(response);
      SurahDto surah = SurahDto.fromJson(jsonData);
      suwars.add(surah);
    }
    return suwars;
  }

  Future<AudioDto> fetchAyahAudio({
    required int surahNo,
    required int ayahNo,
  }) async {
    final response = await api.get(
      ApiEndPoint.getSpecialAyahAudio(surahNumber: surahNo, ayahNumber: ayahNo),
    );
    AudioDto ayahAudio = AudioDto.fromJson(response);
    return ayahAudio;
  }
}
