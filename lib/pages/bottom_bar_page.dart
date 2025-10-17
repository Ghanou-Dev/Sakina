import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/pages/BottomBar/bookmark.dart';
import 'package:sakina/pages/BottomBar/douaa.dart';
import 'package:sakina/pages/BottomBar/idea.dart';
import 'package:sakina/pages/BottomBar/home_page.dart';
import 'package:sakina/pages/BottomBar/mawakit_salat.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  static const String pageRoute = 'BottomBar';

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    Idea(),
    MawakitSalat(),
    Douaa(),
    Bookmark(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: primaryColor,
        unselectedItemColor: secondaryColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Icon.svg',
              color: currentIndex == 0 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/lamp.svg',
              color: currentIndex == 1 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/salat.svg',
              color: currentIndex == 2 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/douaa.svg',
              color: currentIndex == 3 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              color: currentIndex == 4 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
