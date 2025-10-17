class AyahModel {
  final int number;
  final String? audio;
  final String? audioSecondary;
  final String text;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  AyahModel({
    required this.number,
     this.audio,
     this.audioSecondary,
    required this.text,
    required this.numberInSurah,
    required this.juz,
    required this.manzil,
    required this.page,
    required this.ruku,
    required this.hizbQuarter,
  });

  factory AyahModel.fromJson(jsonData) {
    return AyahModel(
      number: jsonData['number'],
      audio: jsonData['audio'],
      audioSecondary: jsonData['audioSecondary'] == null ? null : jsonData['audioSecondary'][0],
      text: jsonData['text'],
      numberInSurah: jsonData['numberInSurah'],
      juz: jsonData['juz'],
      manzil: jsonData['manzil'],
      page: jsonData['page'],
      ruku: jsonData['ruku'],
      hizbQuarter: jsonData['hizbQuarter'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'audio': audio,
      'audioSecondary': audioSecondary,
      'text': text,
      'numberInSurah': numberInSurah,
      'juz': juz,
      'manzil': manzil,
      'page': page,
      'ruku': ruku,
      'hizbQuarter': hizbQuarter,
    };
  }
}
