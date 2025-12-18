import 'package:sakina/core/apis/quran_api1/api1_keys.dart';
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
