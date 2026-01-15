import 'package:sakina/core/apis/quran_audio/reciter_keys.dart';

class MoshafeDto {
  final int id;
  final String name;
  final String server;
  final int surahTotal;
  final int moshafType;
  final List<String> surahList;

  MoshafeDto({
    required this.id,
    required this.name,
    required this.server,
    required this.surahTotal,
    required this.moshafType,
    required this.surahList,
  });

  factory MoshafeDto.fromJson(jsonData) {
    return MoshafeDto(
      id: jsonData[ReciterKeys.id],
      name: jsonData[ReciterKeys.name],
      server: jsonData[ReciterKeys.server],
      surahTotal: jsonData[ReciterKeys.surahTotal],
      moshafType: jsonData[ReciterKeys.moshafType],
      surahList: (jsonData[ReciterKeys.surahList] as String).split(','),
    );
  }
}
