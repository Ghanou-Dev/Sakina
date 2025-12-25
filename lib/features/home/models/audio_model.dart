import 'package:sakina/features/home/models/ayah_model.dart';

class AudioModel {
  final AyahModel affasi;
  final AyahModel shatri;
  final AyahModel qatami;
  final AyahModel adDosari;
  final AyahModel arRifai;

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
