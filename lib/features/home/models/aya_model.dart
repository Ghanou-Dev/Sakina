import 'package:sakina/core/apis/api_keys.dart';

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
      ApiKeys.reciter: reciter,
      ApiKeys.url: url,
      ApiKeys.originalUrl: originalUrl,
    };
  }
}
