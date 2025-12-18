import 'package:sakina/core/apis/quran_api1/api1_keys.dart';

class AyaModel {
  final String reciter;
  final String url;
  final String originalUrl;

  AyaModel({
    required this.reciter,
    required this.url,
    required this.originalUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      Api1Keys.reciter: reciter,
      Api1Keys.url: url,
      Api1Keys.originalUrl: originalUrl,
    };
  }
}
