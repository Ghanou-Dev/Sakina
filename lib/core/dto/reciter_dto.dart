import 'package:sakina/core/apis/quran_audio/reciter_keys.dart';
import 'package:sakina/core/dto/moshafe_dto.dart';

class ReciterDto {
  final int id;
  final String name;
  final String letter;
  final String date;
  final List<MoshafeDto> moshaf;

  ReciterDto({
    required this.id,
    required this.name,
    required this.letter,
    required this.date,
    required this.moshaf,
  });

  factory ReciterDto.fromJson(jsonData) {
    return ReciterDto(
      id: jsonData[ReciterKeys.id],
      name: jsonData[ReciterKeys.name],
      letter: jsonData[ReciterKeys.letter],
      date: jsonData[ReciterKeys.date],
      moshaf: (jsonData[ReciterKeys.moshaf] as List<dynamic>)
          .map((data) => MoshafeDto.fromJson(data))
          .toList(),
    );
  }
}
