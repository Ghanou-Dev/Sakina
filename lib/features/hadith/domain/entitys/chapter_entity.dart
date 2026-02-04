import 'package:equatable/equatable.dart';

class ChapterEntity extends Equatable {
  final int id;
  final String chapterNumber;
  final String chapterEnglish;
  final String chapterUrdu;
  final String chapterArabic;
  final String bookSlug;

  const ChapterEntity({
    required this.id,
    required this.chapterNumber,
    required this.chapterEnglish,
    required this.chapterUrdu,
    required this.chapterArabic,
    required this.bookSlug,
  });

  @override
  List<Object?> get props => [
    id,
    chapterNumber,
    chapterEnglish,
    chapterUrdu,
    chapterArabic,
    bookSlug,
  ];
}
