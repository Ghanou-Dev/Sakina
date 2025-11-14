import 'package:flutter/material.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/widgets/custom_empty_page_item.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoriet',
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Image.asset(
              'assets/images/search.png',
              height: 24,
              width: 24,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // CustomItemFavorietAya(),
            CustomEmptyPageItem(),
          ],
        ),
      ),
    );
  }
}
