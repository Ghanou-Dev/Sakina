import 'package:sakina/core/apis/api_keys.dart';
import 'package:sakina/features/home/models/audio_model.dart';

class SuraModel {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  final int surahNo;
  final AudioModel audio;
  final List<String> english;
  final List<String> arabic1;
  final List<String> arabic2;
  final List<String> bengali;
  final List<String> urdu;

  SuraModel({
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
