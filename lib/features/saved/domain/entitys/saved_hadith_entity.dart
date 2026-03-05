import 'package:equatable/equatable.dart';

class SavedHadithEntity extends Equatable {
  final String hadithArabic;
  final String hadithEnglish;
  final String? headingArabic;
  final String? headingEnglish;
  final String? chapterArabic;
  final String? chapterEnglish;
  final String status;
  final String? englishNarrator;
  const SavedHadithEntity({
    required this.hadithArabic,
    required this.hadithEnglish,
    this.headingArabic,
    this.headingEnglish,
    this.chapterArabic,
    this.chapterEnglish,
    required this.status,
    this.englishNarrator,
  });

  @override
  List<Object?> get props => [
    hadithArabic,
    hadithEnglish,
    headingArabic,
    headingEnglish,
    chapterArabic,
    chapterEnglish,
    status,
    englishNarrator,
  ];
}
