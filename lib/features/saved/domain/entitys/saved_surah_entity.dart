import 'package:equatable/equatable.dart';

class SavedSurahEntity extends Equatable {
  final int numberSurah;
  final String surahArabicName;
  final String surahEnglishName;
  final String reciterName;
  final String mushafeName;
  final String surahUrl;
  final String type;
  final int numberVerses;
  const SavedSurahEntity({
    required this.numberSurah,
    required this.surahArabicName,
    required this.surahEnglishName,
    required this.reciterName,
    required this.mushafeName,
    required this.surahUrl,
    required this.type,
    required this.numberVerses,
  });

  @override
  List<Object?> get props => [
    numberSurah,
    surahArabicName,
    surahEnglishName,
    reciterName,
    surahUrl,
    type,
    numberVerses,
  ];
}
