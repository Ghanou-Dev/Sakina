import 'package:hive_ce/hive_ce.dart';
part 'saved_surah_model.g.dart';

@HiveType(typeId: 1)
class SavedSurahModel extends HiveObject {
  @HiveField(0)
  final int numberSurah;
  @HiveField(1)
  final String surahArabicName;
  @HiveField(2)
  final String surahEnglishName;
  @HiveField(3)
  final String reciterName;
  @HiveField(4)
  final String mushafeName;
  @HiveField(5)
  final String surahUrl;
  @HiveField(6)
  final String type;
  @HiveField(7)
  final int numberVerses;

  SavedSurahModel({
    required this.numberSurah,
    required this.surahArabicName,
    required this.surahEnglishName,
    required this.reciterName,
    required this.mushafeName,
    required this.surahUrl,
    required this.type,
    required this.numberVerses,
  });
}
