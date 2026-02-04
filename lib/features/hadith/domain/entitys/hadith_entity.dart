import 'package:equatable/equatable.dart';

class HadithEntity extends Equatable {
  final int id;
  final String hadithNumber;
  final String? englishNarrator;
  final String hadithEnglish;
  final String? urduNarrator;
  final String hadithUrdu;
  final String hadithArabic;
  final String? headingArabic;
  final String? headingUrdu;
  final String? headingEnglish;
  final String chapterId;
  final String bookSlug;
  final String status;

  const HadithEntity({
    required this.id,
    required this.hadithNumber,
    this.englishNarrator,
    required this.hadithEnglish,
    this.urduNarrator,
    required this.hadithUrdu,
    required this.hadithArabic,
    this.headingArabic,
    this.headingUrdu,
    this.headingEnglish,
    required this.chapterId,
    required this.bookSlug,
    required this.status,
  });

  @override
  List<Object?> get props => [
    id,
    hadithNumber,
    englishNarrator,
    hadithEnglish,
    urduNarrator,
    hadithUrdu,
    hadithArabic,
    headingArabic,
    headingUrdu,
    headingEnglish,
    chapterId,
    bookSlug,
    status,
  ];
}
