import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/constants/fonts.dart';
import 'package:sakina/helpers/extansions.dart';

class Hadith extends StatelessWidget {
  const Hadith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Hadith'.tr(context),
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: SvgPicture.asset(
              'assets/icons/mosque-02.svg',
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CustomHadithLafita(),
            ),
          ),
          Gap(20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomHadithBook(
                    iconPath:
                        'assets/ramadan_icons/Illustration-${index + 1}.png',
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomHadithLafita extends StatelessWidget {
  const CustomHadithLafita({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: size.height / 5,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: size.height / 6,
              width: size.width / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/diker.png'),
                ),
              ),
            ),
            Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ٱلْمَوْسُوعَةُ ٱلْحَدِيثِيَّة',
                  style: TextStyle(
                    fontFamily: poppins,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  ),
                ),
                Text(
                  'Hadith Encyclopedia',
                  style: TextStyle(
                    fontFamily: poppins,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: BoxBorder.all(color: theredColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 16,
                    ),
                    child: Text(
                      '٥ جمادى الثاني ١٤٤٧ هـ',
                      style: TextStyle(
                        fontFamily: poppins,
                        color: theredColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomHadithBook extends StatelessWidget {
  final String iconPath;
  const CustomHadithBook({required this.iconPath, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print("press book");
      },
      splashColor: Colors.black26,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theredColor, width: 1),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
          image: DecorationImage(
            image: AssetImage('assets/images/image12.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      'صحيح البخاري',
                      style: TextStyle(
                        fontFamily: uthmani,
                        fontWeight: FontWeight.bold,
                        color: theredColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
