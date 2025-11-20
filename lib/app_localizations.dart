import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale? locale;
  AppLocalizations({required this.locale});

  //
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of(context, AppLocalizations);
  }

  // load json localizations files
  late Map<String, String> localizationFile;
  Future<void> loadFiles() async {
    final jsonFile = await rootBundle.loadString(
      'assets/l10n/${locale!.languageCode}.json',
    );
    Map<String, dynamic> jsonMap = jsonDecode(jsonFile);
    localizationFile = jsonMap.map((k, v) => MapEntry(k, v.toString()));
  }

  String translate(String key) {
    return localizationFile[key] ?? '';
  }

  // create delegate
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale: locale);
    await appLocalizations.loadFiles();
    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<dynamic> old) {
    return false;
  }
}
