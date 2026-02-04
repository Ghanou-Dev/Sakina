import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/constants/fonts.dart';

class CustomHadithLafita extends StatelessWidget {
  const CustomHadithLafita({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: size.height / 6,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: size.height / 6,
              width: size.width / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/diker.png'),
                ),
              ),
            ),
            Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ٱلْمَوْسُوعَةُ ٱلْحَدِيثِيَّة',
                  style: TextStyle(
                    fontFamily: poppins,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Text(
                  'Hadith Encyclopedia',
                  style: TextStyle(
                    fontFamily: poppins,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                Gap(20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
