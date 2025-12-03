import 'package:hive_ce_flutter/hive_flutter.dart';

@HiveType(typeId: 0)
class AyahModel extends HiveObject {
  @HiveField(0)
  final int number;
  @HiveField(1)
  final String? audio;
  @HiveField(2)
  final String? audioSecondary;
  @HiveField(3)
  final String text;
  @HiveField(4)
  final int numberInSurah;
  @HiveField(5)
  final int juz;
  @HiveField(6)
  final int manzil;
  @HiveField(7)
  final int page;
  @HiveField(8)
  final int ruku;
  @HiveField(9)
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
      audioSecondary: jsonData['audioSecondary'] == null
          ? null
          : jsonData['audioSecondary'][0],
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
