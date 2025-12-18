import 'package:sakina/core/apis/quran_api1/api1_keys.dart';

class SurahDto {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  final int surahNo;
  final AudioDto audio;
  final List<String> english;
  final List<String> arabic1;
  final List<String> arabic2;
  final List<String> bengali;
  final List<String> urdu;

  SurahDto({
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
    required this.surahNo,
    required this.audio,
    required this.english,
    required this.arabic1,
    required this.arabic2,
    required this.bengali,
    required this.urdu,
  });

  factory SurahDto.fromJson(jsonData) {
    return SurahDto(
      surahName: jsonData[Api1Keys.surahName],
      surahNameArabic: jsonData[Api1Keys.surahNameArabic],
      surahNameArabicLong: jsonData[Api1Keys.surahNameArabicLong],
      surahNameTranslation: jsonData[Api1Keys.surahNameTranslation],
      revelationPlace: jsonData[Api1Keys.revelationPlace],
      totalAyah: jsonData[Api1Keys.totalAyah],
      surahNo: jsonData[Api1Keys.surahNo],
      audio: AudioDto.fromJson(jsonData[Api1Keys.audio]),
      english: jsonData[Api1Keys.english],
      arabic1: jsonData[Api1Keys.arabic1],
      arabic2: jsonData[Api1Keys.arabic2],
      bengali: jsonData[Api1Keys.bengali],
      urdu: [Api1Keys.urdu],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Api1Keys.surahName: surahName,
      Api1Keys.surahNameArabic: surahNameArabic,
      Api1Keys.surahNameArabicLong: surahNameArabicLong,
      Api1Keys.surahNameTranslation: surahNameTranslation,
      Api1Keys.revelationPlace: revelationPlace,
      Api1Keys.totalAyah: totalAyah,
      Api1Keys.surahNo: surahNo,
      Api1Keys.audio: audio,
      Api1Keys.english: english,
      Api1Keys.arabic1: arabic1,
      Api1Keys.arabic2: arabic2,
      Api1Keys.bengali: bengali,
      Api1Keys.urdu: urdu,
    };
  }
}

class AyahDto {
  final String reciter;
  final String url;
  final String originalUrl;

  AyahDto({
    required this.reciter,
    required this.url,
    required this.originalUrl,
  });

  factory AyahDto.fromJson(jsonData) {
    return AyahDto(
      reciter: jsonData[Api1Keys.reciter],
      url: jsonData[Api1Keys.url],
      originalUrl: jsonData[Api1Keys.originalUrl],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      Api1Keys.reciter: reciter,
      Api1Keys.url: url,
      Api1Keys.originalUrl: originalUrl,
    };
  }
}

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
