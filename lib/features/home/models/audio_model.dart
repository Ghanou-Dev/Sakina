import 'package:sakina/features/home/models/aya_model.dart';

class AudioModel {
  final AyaModel affasi;
  final AyaModel shatri;
  final AyaModel qatami;
  final AyaModel adDosari;
  final AyaModel arRifai;

  AudioModel({
    required this.affasi,
    required this.shatri,
    required this.qatami,
    required this.adDosari,
    required this.arRifai,
  });

  Map<String, dynamic> toMap() {
    return {
      'affasi': affasi,
      'shatri': shatri,
      'qatami': qatami,
      'adDosari': adDosari,
      'arRifai': arRifai,
    };
  }
}
