import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';

class ItemSurahInfo extends StatelessWidget {
  final String surahName;
  final String surahNameArabic;
  final String surahNameArabicLong;
  final String surahNameTranslation;
  final String revelationPlace;
  final int totalAyah;
  final int index;
  const ItemSurahInfo({
    super.key,
    required this.surahName,
    required this.surahNameArabic,
    required this.surahNameArabicLong,
    required this.surahNameTranslation,
    required this.revelationPlace,
    required this.totalAyah,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontFamily: poppins,
                      color: theredColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/IconSurah.svg',
                width: 40,
                height: 40,
              ),
            ],
          ),
          title: Text(
            surahName,
            style: TextStyle(
              fontFamily: poppins,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: theredColor,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                revelationPlace,
                style: TextStyle(
                  fontFamily: poppins,
                  color: secondaryColor,
                  fontSize: 12,
                ),
              ),
              Gap(4),
              Text(
                '.',
                style: TextStyle(
                  fontFamily: poppins,
                  color: secondaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(4),
              Text(
                '$totalAyah VERSES',
                style: TextStyle(
                  fontFamily: poppins,
                  color: secondaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: Text(
            surahNameArabicLong,
            style: TextStyle(
              fontFamily: amiri,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
