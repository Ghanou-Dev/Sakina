import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';

class TaffsirOfSurahPage extends StatefulWidget {
  const TaffsirOfSurahPage({
    super.key,
  });

  @override
  State<TaffsirOfSurahPage> createState() => _TaffsirOfSurahPageState();
}

class _TaffsirOfSurahPageState extends State<TaffsirOfSurahPage> {
  late ScrollController scrollController;
  Timer? debounced;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Taffsir of surah ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: poppins,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return CustomTaffsirOfSurah(
                    ayahTaffsir: 'widget.surahTaffsir.ayahs[index].text',
                    ayahText: 'widget.surahText.ayahs[index].text',
                    number: index += 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTaffsirOfSurah extends StatelessWidget {
  final String ayahText;
  final String ayahTaffsir;
  final int number;
  const CustomTaffsirOfSurah({
    required this.ayahText,
    required this.ayahTaffsir,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(color: AppColors.orange, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ayah N° : $number',
                    style: TextStyle(
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                      color: AppColors.orange,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      ayahText,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.silver,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      ayahTaffsir,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: AppColors.deepBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16.0),
          child: Divider(
            color: AppColors.orange,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
