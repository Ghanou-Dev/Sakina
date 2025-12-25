import 'package:sakina/core/apis/quran/quran_api_keys.dart';

class AyahDto {
  final String reciter;
  final String url;
  final String originalUrl;

  AyahDto({
    required this.reciter,
    required this.url,
    required this.originalUrl,
  });

  factory AyahDto.fromJson(jsonData) {
    return AyahDto(
      reciter: jsonData[QuranApiKeys.reciter],
      url: jsonData[QuranApiKeys.url],
      originalUrl: jsonData[QuranApiKeys.originalUrl],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      QuranApiKeys.reciter: reciter,
      QuranApiKeys.url: url,
      QuranApiKeys.originalUrl: originalUrl,
    };
  }
}
