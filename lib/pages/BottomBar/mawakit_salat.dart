import 'package:flutter/material.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';

class MawakitSalat extends StatelessWidget {
  const MawakitSalat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mawaqit Al-Salat',
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
