import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/widgets/custom_item_surah.dart';
import 'package:sakina/widgets/custom_item_ayah.dart';

class DisplaySurahPage extends StatelessWidget {
  final CustomItemSurah surah;
  final CustomItemSurah surahEnglish;
  const DisplaySurahPage({
    required this.surah,
    required this.surahEnglish,
    super.key,
  });

  static const String pageRoute = 'desplaySurahPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          surah.name,
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: secondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/search.png'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/background.png',
                    width: double.infinity,
                    height: 257,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 25,
                    ),
                    Text(
                      surah.name,
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                    Gap(10),
                    Text(
                      surah.englishName,
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 8,
                      ),
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          surah.revelationType.toUpperCase(),
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Gap(4),
                        Text(
                          '.',
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(4),
                        Text(
                          '${surah.ayahs.length} VERSES',
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Gap(40),
                    SvgPicture.asset('assets/icons/bismi_allah.svg'),
                  ],
                ),
              ],
            ),
            Gap(30),
            Expanded(
              child: ListView.builder(
                itemCount: surah.ayahs.length,
                itemBuilder: (context, index) {
                  return CustomItemAyah(
                    surah: surah,
                    ayah: surah.ayahs[index],
                    ayahEnglish: surahEnglish.ayahs[index],
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
