import 'package:flutter/material.dart';
import 'package:sakina/features/home/models/audio_model.dart';

class ItemSurah extends StatelessWidget {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  final int index;
  final int surahNo;
  final AudioModel audio;
  final List<dynamic> english;
  final List<dynamic> arabic1;
  final List<dynamic> arabic2;
  final List<dynamic> bengali;
  final List<dynamic> urdu;
  const ItemSurah({
    super.key,
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
    required this.index,
    required this.surahNo,
    required this.audio,
    required this.english,
    required this.arabic1,
    required this.arabic2,
    required this.bengali,
    required this.urdu,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
