class LanguagesQuraneData {
  final String id;
  final String language;
  final String native;
  final String locale;
  final String surah;
  final String rewayah;
  final String reciters;
  final String radios;
  final String tafasir;
  const LanguagesQuraneData({
    required this.id,
    required this.language,
    required this.native,
    required this.locale,
    required this.surah,
    required this.rewayah,
    required this.reciters,
    required this.radios,
    required this.tafasir,
  });

  factory LanguagesQuraneData.fromJson(jsonData) {
    return LanguagesQuraneData(
      id: jsonData['id'],
      language: jsonData['language'],
      native: jsonData['native'],
      locale: jsonData['locale'],
      surah: jsonData['surah'],
      rewayah: jsonData['rewayah'],
      reciters: jsonData['reciters'],
      radios: jsonData['radios'],
      tafasir: jsonData['tafasir'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'language': language,
      'native': native,
      'locale': locale,
      'surah': surah,
      'rewayah': rewayah,
      'reciters': reciters,
      'radios': radios,
      'tafasir': tafasir,
    };
  }
}
