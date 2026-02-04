import 'package:sakina/features/hadith/data/hadith_endpointes.dart';
import 'package:sakina/features/hadith/domain/entitys/hadith_entity.dart';

class HadithModel extends HadithEntity {
  const HadithModel({
    required super.id,
    required super.hadithNumber,
    required super.englishNarrator,
    required super.hadithEnglish,
    required super.urduNarrator,
    required super.hadithUrdu,
    required super.hadithArabic,
    required super.headingArabic,
    required super.headingUrdu,
    required super.headingEnglish,
    required super.chapterId,
    required super.bookSlug,
    required super.status,
  });

  @override
  List<Object?> get props => super.props;

  factory HadithModel.fromJson(jsonData) {
    return HadithModel(
      id: jsonData[HadithEndpointes.id],
      hadithNumber: jsonData[HadithEndpointes.hadithNumber],
      englishNarrator: jsonData[HadithEndpointes.englishNarrator],
      hadithEnglish: jsonData[HadithEndpointes.hadithEnglish],
      urduNarrator: jsonData[HadithEndpointes.urduNarrator],
      hadithUrdu: jsonData[HadithEndpointes.hadithUrdu],
      hadithArabic: jsonData[HadithEndpointes.hadithArabic],
      headingArabic: jsonData[HadithEndpointes.headingArabic],
      headingUrdu: jsonData[HadithEndpointes.headingUrdu],
      headingEnglish: jsonData[HadithEndpointes.headingEnglish],
      chapterId: jsonData[HadithEndpointes.chapterId],
      bookSlug: jsonData[HadithEndpointes.bookSlug],
      status: jsonData[HadithEndpointes.status],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      HadithEndpointes.id: id,
      HadithEndpointes.hadithNumber: hadithNumber,
      HadithEndpointes.englishNarrator: englishNarrator,
      HadithEndpointes.hadithEnglish: hadithEnglish,
      HadithEndpointes.urduNarrator: urduNarrator,
      HadithEndpointes.hadithUrdu: hadithUrdu,
      HadithEndpointes.hadithArabic: hadithArabic,
      HadithEndpointes.headingArabic: headingArabic,
      HadithEndpointes.headingUrdu: headingUrdu,
      HadithEndpointes.headingEnglish: headingEnglish,
      HadithEndpointes.chapterId: chapterId,
      HadithEndpointes.bookSlug: bookSlug,
      HadithEndpointes.status: status,
    };
  }
}
