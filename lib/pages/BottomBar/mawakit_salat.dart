import 'package:flutter/material.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/constants/fonts.dart';
import 'package:sakina/helpers/extansions.dart';

class MawakitSalat extends StatelessWidget {
  const MawakitSalat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mawaqit Al-Salat'.tr(context),
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
