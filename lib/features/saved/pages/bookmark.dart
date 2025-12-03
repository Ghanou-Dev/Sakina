import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';
// import 'package:sakina/widgets/custom_empty_page_item.dart';
// import 'package:sakina/widgets/custom_item_favoriet_aya.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Favoriet'.tr(context),
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FavorietBody(),
      ),
    );
  }
}

class FavorietBody extends StatelessWidget {
  const FavorietBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomHadithWidget(),
        Gap(size.height / 40),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            padding: EdgeInsets.all(6),
            shrinkWrap: true,
            children: [
              CustomFavorietPart(
                partName: 'Surah ',
                pathIcon: 'assets/icons/surah_text_icon.svg',
                onTap: () {},
              ),
              CustomFavorietPart(
                partName: 'Listen',
                pathIcon: 'assets/icons/listen_icon.svg',
                onTap: () {},
              ),
              CustomFavorietPart(
                partName: 'Ayah',
                pathIcon: 'assets/icons/sibha_icon.svg',
                onTap: () {},
              ),
              CustomFavorietPart(
                partName: 'Taffsir',
                pathIcon: 'assets/icons/hadith_icon.svg',
                onTap: () {},
              ),
              CustomFavorietPart(
                partName: 'Hadith',
                pathIcon: 'assets/icons/surah_text_icon.svg',
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomHadithWidget extends StatelessWidget {
  const CustomHadithWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height / 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 10,
            color: primaryColor,
          ),
        ],
        image: DecorationImage(
          image: AssetImage(
            'assets/images/background.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Text(
                'روى مسلم في صحيحه أن النبي ﷺ قال',
                style: TextStyle(
                  fontFamily: amiri,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Gap(10),
            Align(
              alignment: Alignment.center,
              child: Text(
                "يُقالُ لِصاحِبِ القُرآنِ: اقرأْ وارْتَقِ ورَتِّلْ كما كُنْتَ تُرَتِّلُ في الدُّنْيا، فإنَّ مَنْزِلَتَكَ عِنْدَ آخِرِ آيَةٍ تَقْرَؤُها.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: poppins,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Gap(10),
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                'صحيح مسلم',
                style: TextStyle(
                  fontFamily: amiri,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomFavorietPart extends StatelessWidget {
  final String partName;
  final String pathIcon;
  final void Function()? onTap;
  const CustomFavorietPart({
    required this.partName,
    required this.pathIcon,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: primaryColor),
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 0,
                color: Colors.black45,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Text(
                    partName,
                    style: TextStyle(
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      fontSize: 18,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: SvgPicture.asset(
                    pathIcon,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
