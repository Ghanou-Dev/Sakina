import 'package:sakina/features/home/models/reciter_model.dart';

class ReciterChikhModel {
  final int id;
  final String name;
  final String letter;
  final String date;
  final List<ReciterModel> moshaf;
  const ReciterChikhModel({
    required this.id,
    required this.name,
    required this.letter,
    required this.date,
    required this.moshaf,
  });

  factory ReciterChikhModel.fromJson(jsonData) {
    return ReciterChikhModel(
      id: jsonData['id'],
      name: jsonData['name'],
      letter: jsonData['letter'],
      date: jsonData['date'],
      moshaf: (jsonData['moshaf'] as List<dynamic>)
          .map((reciter) => ReciterModel.fromJson(reciter))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'letter': letter,
      'date': date,
      'moshaf': moshaf,
    };
  }
}
