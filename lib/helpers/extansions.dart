import 'package:flutter/material.dart';
import 'package:sakina/app_localizations.dart';

extension TranslatX on String {
  String tr(BuildContext context) {
    return AppLocalizations.of(context)!.translate(this);
  }
}
