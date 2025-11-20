import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/constants/fonts.dart';

class CustomEmptyPageItem extends StatelessWidget {
  const CustomEmptyPageItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
        ),
        Text(
          'Your favorites list is empty!',
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.normal,
            color: theredColor,
            fontSize: 16,
          ),
        ),
        Text(
          'Add items here to find them easily later',
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.normal,
            color: theredColor,
            fontSize: 16,
          ),
        ),
        Gap(10),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.bookmark_add_outlined,
            color: primaryColor,
            size: 40,
          ),
        ),
      ],
    );
  }
}
