import 'package:sakina/core/apis/api_keys.dart';

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
      surahName: jsonData[ApiKeys.surahName],
      surahNameArabic: jsonData[ApiKeys.surahNameArabic],
      surahNameArabicLong: jsonData[ApiKeys.surahNameArabicLong],
      surahNameTranslation: jsonData[ApiKeys.surahNameTranslation],
      revelationPlace: jsonData[ApiKeys.revelationPlace],
      totalAyah: jsonData[ApiKeys.totalAyah],
      surahNo: jsonData[ApiKeys.surahNo],
      audio: AudioDto.fromJson(jsonData[ApiKeys.audio]),
      english: jsonData[ApiKeys.english],
      arabic1: jsonData[ApiKeys.arabic1],
      arabic2: jsonData[ApiKeys.arabic2],
      bengali: jsonData[ApiKeys.bengali],
      urdu: [ApiKeys.urdu],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ApiKeys.surahName: surahName,
      ApiKeys.surahNameArabic: surahNameArabic,
      ApiKeys.surahNameArabicLong: surahNameArabicLong,
      ApiKeys.surahNameTranslation: surahNameTranslation,
      ApiKeys.revelationPlace: revelationPlace,
      ApiKeys.totalAyah: totalAyah,
      ApiKeys.surahNo: surahNo,
      ApiKeys.audio: audio,
      ApiKeys.english: english,
      ApiKeys.arabic1: arabic1,
      ApiKeys.arabic2: arabic2,
      ApiKeys.bengali: bengali,
      ApiKeys.urdu: urdu,
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
      reciter: jsonData[ApiKeys.reciter],
      url: jsonData[ApiKeys.url],
      originalUrl: jsonData[ApiKeys.originalUrl],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      ApiKeys.reciter: reciter,
      ApiKeys.url: url,
      ApiKeys.originalUrl: originalUrl,
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
