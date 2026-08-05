import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';

class SalatItem extends StatelessWidget {
  final bool isTime;
  final String nameSalat;
  final String time;
  final String iconPath;
  const SalatItem({
    super.key,
    required this.isTime,
    required this.nameSalat,
    required this.time,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: isTime ? Color(0xffdd96fa).withAlpha(400) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isTime ? AppColors.primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  iconPath,
                  height: 36,
                  width: 36,
                ),
              ),
              Gap(10),
              Text(
                nameSalat,
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: AppColors.deepBlue,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  time,
                  style: TextStyle(
                    fontFamily: poppins,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
