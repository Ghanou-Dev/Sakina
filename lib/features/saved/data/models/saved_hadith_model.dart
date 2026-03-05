import 'package:hive_ce/hive.dart';
part 'saved_hadith_model.g.dart';

@HiveType(typeId: 2)
class SavedHadithModel extends HiveObject {
  @HiveField(0)
  final String hadithArabic;
  @HiveField(1)
  final String hadithEnglish;
  @HiveField(2)
  final String? headingArabic;
  @HiveField(3)
  final String? headingEnglish;
  @HiveField(4)
  final String? chapterArabic;
  @HiveField(5)
  final String? chapterEnglish;
  @HiveField(6)
  final String status;
  @HiveField(7)
  final String? englishNarrator;

  SavedHadithModel({
    required this.hadithArabic,
    required this.hadithEnglish,
    this.headingArabic,
    this.headingEnglish,
    this.chapterArabic,
    this.chapterEnglish,
    required this.status,
    this.englishNarrator,
  });
}
