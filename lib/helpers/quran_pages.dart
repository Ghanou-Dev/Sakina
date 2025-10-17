class QuranPages {
  static List<String> getQuranImages() {
    List<String> pagesUrl = [];
    for (int a = 1; a <= 604; a++) {
      pagesUrl.add(
        'https://raw.githubusercontent.com/BetimShala/quran-images-api/master/quran-images/$a.png',
      );
    }

    return pagesUrl;
  }

  
}
