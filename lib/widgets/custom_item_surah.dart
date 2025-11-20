import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/constants/fonts.dart';
import 'package:sakina/models/ayah_model.dart';

class CustomItemSurah extends StatelessWidget {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final String revelationType;
  final List<AyahModel> ayahs;
  const CustomItemSurah({
    super.key,
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.revelationType,
    required this.ayahs,
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
                    '$number',
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
            englishName,
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
                revelationType,
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
                '${ayahs.length} VERSES',
                style: TextStyle(
                  fontFamily: poppins,
                  color: secondaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: Text(
            name,
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
