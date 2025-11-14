import 'package:flutter/material.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        // leading: TextButton(
        //   onPressed: () {},
        //   child: Image.asset(
        //     'assets/images/menu.png',
        //     height: 24,
        //     width: 24,
        //   ),
        // ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}
