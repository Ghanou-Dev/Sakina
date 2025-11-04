import 'package:flutter/material.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';

class Douaa extends StatelessWidget {
  const Douaa({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ahadiith',
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        leading: TextButton(
          onPressed: () {},
          child: Image.asset(
            'assets/images/menu.png',
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }
}
