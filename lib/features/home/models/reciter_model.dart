import 'package:sakina/features/home/models/moshafe_model.dart';

class ReciterModel {
  final int id;
  final String name;
  final String letter;
  final String date;
  final List<MoshafeModel> moshaf;

  ReciterModel({
    required this.id,
    required this.name,
    required this.letter,
    required this.date,
    required this.moshaf,
  });
}
