import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sakina/core/apis/api_consumer.dart';
import 'package:sakina/core/apis/quran/quran_endpoint.dart';
import 'package:sakina/core/dto/audio_dto.dart';
import 'package:sakina/core/dto/surah_dto.dart';
import 'package:sakina/core/dto/surah_info_dto.dart';

class QuraneService {
  final ApiConsumer api;
  const QuraneService({required this.api});

  Future<SurahDto> fetchSpecialSurah({required int surahNumber}) async {
    final data = await api.get(
      QuranEndpoint.getSpecialSurahInfo(surahNumber: surahNumber),
    );
    // final jsonData = jsonDecode(data);
    SurahDto surah = SurahDto.fromJson(data);
    return surah;
  }

  Future<List<SurahInfoDto>> fetchAllSuwarsInfo() async {
    try {
      final response = await rootBundle.loadString(
        'assets/data/titles_of_all_surahs.json',
      );
      List<dynamic> jsonData = jsonDecode(response);
      List<SurahInfoDto> infoSuwars = jsonData
          .map((j) => SurahInfoDto.fromJson(j))
          .toList();
      return infoSuwars;
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw Exception();
    }
  }

  Future<AudioDto> fetchAyahAudio({
    required int surahNo,
    required int ayahNo,
  }) async {
    final response = await api.get(
      QuranEndpoint.getSpecialAyahAudio(
        surahNumber: surahNo,
        ayahNumber: ayahNo,
      ),
    );
    AudioDto ayahAudio = AudioDto.fromJson(response);
    return ayahAudio;
  }
}
