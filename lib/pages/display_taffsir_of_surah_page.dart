import 'package:flutter/material.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/widgets/custom_item_surah.dart';

class DisplayTaffsirOfSurahPage extends StatelessWidget {
  final CustomItemSurah surahText;
  final CustomItemSurah surahTaffsir;
  const DisplayTaffsirOfSurahPage({
    required this.surahText,
    required this.surahTaffsir,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Taffsir of surah ${surahText.englishName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: poppins,
            color: primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}

class CustomTaffsirOfSurah extends StatelessWidget {
  const CustomTaffsirOfSurah({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: []);
  }
}
