import 'package:sakina/core/dto/ayah_dto.dart';

class AudioDto {
  final AyahDto one;
  final AyahDto tow;
  final AyahDto three;
  final AyahDto fore;
  final AyahDto five;

  AudioDto({
    required this.one,
    required this.tow,
    required this.three,
    required this.fore,
    required this.five,
  });

  factory AudioDto.fromJson(jsonData) {
    return AudioDto(
      one: AyahDto.fromJson(jsonData['1']),
      tow: AyahDto.fromJson(jsonData['2']),
      three: AyahDto.fromJson(jsonData['3']),
      fore: AyahDto.fromJson(jsonData['4']),
      five: AyahDto.fromJson(jsonData['5']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '1': one,
      '2': tow,
      '3': three,
      '4': fore,
      '5': five,
    };
  }
}
