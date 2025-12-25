import 'package:sakina/core/apis/quran/quran_api_keys.dart';

class SurahInfoModel {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  SurahInfoModel({
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
  });

  factory SurahInfoModel.fromJson(jsonData) {
    return SurahInfoModel(
      surahName: jsonData[QuranApiKeys.surahName],
      surahNameArabic: jsonData[QuranApiKeys.surahNameArabic],
      surahNameArabicLong: jsonData[QuranApiKeys.surahNameArabicLong],
      surahNameTranslation: jsonData[QuranApiKeys.surahNameTranslation],
      revelationPlace: jsonData[QuranApiKeys.revelationPlace],
      totalAyah: jsonData[QuranApiKeys.totalAyah],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      QuranApiKeys.surahName: surahName,
      QuranApiKeys.surahNameArabic: surahNameArabic,
      QuranApiKeys.surahNameArabicLong: surahNameArabicLong,
      QuranApiKeys.surahNameTranslation: surahNameTranslation,
      QuranApiKeys.revelationPlace: revelationPlace,
      QuranApiKeys.totalAyah: totalAyah,
    };
  }
}
