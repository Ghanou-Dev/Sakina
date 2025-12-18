class Api1Endpoint {
  // base url : quranapi.pages.dev/api/

  static String getSpecialSurahInfo({required int surahNumber}) {
    return 'quranapi.pages.dev/api/$surahNumber.json';
  } // endpoint : surah.json

  static String getSpecialAyahAudio({
    required int surahNumber,
    required int ayahNumber,
  }) {
    return 'quranapi.pages.dev/api/audio/$surahNumber/$ayahNumber.json';
  } // endpoint : audio/2/1.json
}
