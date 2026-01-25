import 'package:sakina/features/home/models/taffsir_ayah_model.dart';

class TaffsirSurahModel {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<TaffsirAyahModel> ayahs;
  TaffsirSurahModel({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.ayahs,
  });

  factory TaffsirSurahModel.fromJson(jsonData) {
    return TaffsirSurahModel(
      number: jsonData['number'],
      name: jsonData['name'],
      englishName: jsonData['englishName'],
      englishNameTranslation: jsonData['englishNameTranslation'],
      revelationType: jsonData['revelationType'],
      ayahs: (jsonData['ayahs'] as List<dynamic>)
          .map((data) => TaffsirAyahModel.fromJson(data))
          .toList(),
    );
  }
}
