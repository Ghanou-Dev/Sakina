import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/models/reciter_chikh_model.dart';

class ReciterChikhItem extends StatelessWidget {
  final int index;
  final ReciterChikhModel chikh;
  const ReciterChikhItem({required this.index, required this.chikh, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 70,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
          ),
          Gap(10),
          Stack(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Center(
                  child: Text(
                    '$index',
                    style: TextStyle(
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                      color: theredColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SvgPicture.asset(
                'assets/icons/IconSurah.svg',
                width: 42,
                height: 42,
              ),
            ],
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Text(
                'الشيخ',
                style: TextStyle(
                  fontFamily: amiri,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontSize: 18,
                ),
              ),
              Gap(20),
              Text(
                chikh.name,
                style: TextStyle(
                  fontFamily: amiri,
                  fontWeight: FontWeight.bold,
                  color: theredColor,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
