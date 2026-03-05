import 'package:hive_ce/hive_ce.dart';
part 'saved_ayah_model.g.dart';

@HiveType(typeId: 0)
class SavedAyahModel extends HiveObject {
  @HiveField(0)
  final String textArabic;
  @HiveField(1)
  final String textEnglish;
  @HiveField(2)
  final String taffsir;
  @HiveField(3)
  final int ayahNumber;
  @HiveField(4)
  final String surahArabicName;
  @HiveField(5)
  final String surahEnglishName;
  @HiveField(6)
  final int surahNumber;

  SavedAyahModel({
    required this.textArabic,
    required this.textEnglish,
    required this.taffsir,
    required this.ayahNumber,
    required this.surahArabicName,
    required this.surahEnglishName,
    required this.surahNumber,
  });
}
