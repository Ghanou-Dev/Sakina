import 'package:equatable/equatable.dart';

class SavedAyahEntity extends Equatable {
  final String textArabic;
  final String textEnglish;
  final String taffsir;
  final int ayahNumber;
  final String surahArabicName;
  final String surahEnglishName;
  final int surahNumber;
  const SavedAyahEntity({
    required this.textArabic,
    required this.textEnglish,
    required this.taffsir,
    required this.ayahNumber,
    required this.surahArabicName,
    required this.surahEnglishName,
    required this.surahNumber,
  });

  @override
  List<Object?> get props => [
    textArabic,
    textEnglish,
    taffsir,
    ayahNumber,
    surahArabicName,
    surahEnglishName,
    surahNumber,
  ];
}
