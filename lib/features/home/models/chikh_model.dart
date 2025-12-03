import 'package:sakina/core/constants/chikh_model_keys.dart';

class ChikhModel {
  final String identifier;
  final String language;
  final String name;
  final String englishName;
  final String format;
  final String type;
  final String? direction;
  const ChikhModel({
    required this.identifier,
    required this.language,
    required this.name,
    required this.englishName,
    required this.format,
    required this.type,
    this.direction,
  });

  factory ChikhModel.fromJson(jsonData) {
    return ChikhModel(
      identifier: jsonData[identifierKey],
      language: jsonData[languageKey],
      name: jsonData[nameKey],
      englishName: jsonData[englishNameKey],
      format: jsonData[formatKey],
      type: jsonData[typeKey],
      direction: jsonData[directionKey],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      identifierKey: identifier,
      languageKey: language,
      nameKey: name,
      englishNameKey: englishName,
      formatKey: format,
      typeKey: type,
      directionKey: direction,
    };
  }
}
