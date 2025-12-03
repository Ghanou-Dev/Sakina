import 'package:sakina/features/home/models/ayah_model.dart';

class SurahModel {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<AyahModel> ayahs;
  SurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.ayahs,
  });

  factory SurahModel.fromJson(Map<String, dynamic> jsonData) {
    return SurahModel(
      number: jsonData['number'],
      name: jsonData['name'],
      englishName: jsonData['englishName'],
      englishNameTranslation: jsonData['englishNameTranslation'],
      revelationType: jsonData['revelationType'],
      ayahs: (jsonData['ayahs'] as List<dynamic>)
          .map((ayah) => AyahModel.fromJson(ayah))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'name': name,
      'englishName': englishName,
      'englishNameTranslation': englishNameTranslation,
      'revelationType': revelationType,
      'ayahs': ayahs,
    };
  }
}
