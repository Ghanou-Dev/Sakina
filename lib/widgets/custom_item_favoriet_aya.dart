import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';

class CustomItemFavorietAya extends StatelessWidget {
  const CustomItemFavorietAya({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xffd680f8),
                primaryColor,
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  'Al-Fatihaa',
                  style: TextStyle(
                    fontFamily: amiri,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Color(0xfff3f3f4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 18,
                  child: Text(
                    '1',
                    style: TextStyle(
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.share_outlined,
                    size: 26,
                    color: primaryColor,
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.play_arrow_outlined,
                    size: 32,
                    color: primaryColor,
                  ),
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark,
                    size: 26,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        Gap(24),
        Row(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                "ٱلْحَمْدُ لِلَّهِ رَبِّ ٱلْعَٰلَمِينَ",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontFamily: amiri,
                  fontWeight: FontWeight.bold,
                  color: theredColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        Gap(20),
        Row(
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              child: Text(
                "All praise is due to God alone, the Sustainer of all the worlds,",
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.normal,
                  color: theredColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        Gap(22),
        Divider(),
      ],
    );
  }
}
