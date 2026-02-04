import 'package:sakina/features/hadith/data/hadith_endpointes.dart';
import 'package:sakina/features/hadith/domain/entitys/chapter_entity.dart';

class ChapterModel extends ChapterEntity {
  const ChapterModel({
    required super.id,
    required super.chapterNumber,
    required super.chapterEnglish,
    required super.chapterUrdu,
    required super.chapterArabic,
    required super.bookSlug,
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

  factory ChapterModel.fromJson(jsonData) {
    return ChapterModel(
      id: jsonData[HadithEndpointes.id],
      chapterNumber: jsonData[HadithEndpointes.chapterNumber],
      chapterEnglish: jsonData[HadithEndpointes.chapterEnglish],
      chapterUrdu: jsonData[HadithEndpointes.chapterUrdu],
      chapterArabic: jsonData[HadithEndpointes.chapterArabic],
      bookSlug: jsonData[HadithEndpointes.bookSlug],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      HadithEndpointes.id: id,
      HadithEndpointes.chapterNumber: chapterNumber,
      HadithEndpointes.chapterEnglish: chapterEnglish,
      HadithEndpointes.chapterUrdu: chapterUrdu,
      HadithEndpointes.chapterArabic: chapterArabic,
      HadithEndpointes.bookSlug: bookSlug,
    };
  }
}
