class ReciterEndpoint {
  static String getAllRecitersUrl() {
    return 'https://www.mp3quran.net/api/v3/reciters?language=ar';
  }

  static List<String> getSpecialSurahAudioUrl({
    required String server,
    required List<String> surahNumbers,
  }) {
    List<String> moshafeUrls = [];
    for (String surahNum in surahNumbers) {
      moshafeUrls.add('$server${surahNum.padLeft(3, '0')}.mp3');
    }

    return moshafeUrls;
  }
}
