class TaffsirAyahModel {
  final int number;
  final String text;
  final int numberInSurah;
  TaffsirAyahModel({
    required this.number,
    required this.text,
    required this.numberInSurah,
  });

  factory TaffsirAyahModel.fromJson(jsonData) {
    return TaffsirAyahModel(
      number: jsonData['number'],
      text: jsonData['text'],
      numberInSurah: jsonData['numberInSurah'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'text': text,
      'numberInSurah': numberInSurah,
    };
  }
}
