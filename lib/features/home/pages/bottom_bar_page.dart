import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/core/connection/presentation/cubit/network_cubit.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/saved/presentation/pages/bookmark.dart';
import 'package:sakina/features/hadith/presentation/pages/hadith_page.dart';
import 'package:sakina/features/settings/pages/settings.dart';
import 'package:sakina/features/home/pages/home_page.dart';
import 'package:sakina/features/prayer/pages/mawakit_salat.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  static const String pageRoute = 'BottomBar';

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  @override
  void initState() {
    super.initState();
  }

  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    Hadith(),
    MawakitSalat(),
    Bookmark(),
    Settings(),
  ];

  bool isShowBar = false;
  bool isConnected = true;
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<NetWorkCubit, NetWorkState>(
          listener: (context, state) {
            if (state is NetWorkChanges) {
              if (state.isConnected) {
                setState(() {
                  isShowBar = true;
                  isConnected = true;
                });
                timer?.cancel();
                timer = Timer(
                  Duration(seconds: 2),
                  () {
                    setState(() {
                      isShowBar = false;
                      isConnected = true;
                    });
                  },
                );
              } else {
                setState(() {
                  isShowBar = true;
                  isConnected = false;
                });
              }
            }
          },
          builder: (context, state) {
            if (state is NetWorkChanges) {
              return Column(
                children: [
                  isShowBar
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 32,
                          color: isConnected ? Colors.green : Colors.red,
                          child: Center(
                            child: Text(
                              isConnected ? 'Connection' : 'No Internet',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: poppins,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  Expanded(
                    child: IndexedStack(
                      index: currentIndex,
                      children: pages,
                    ),
                  ),
                ],
              );
            } else {
              return IndexedStack(
                index: currentIndex,
                children: pages,
              );
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) {
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.grey,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Icon.svg',
              color: currentIndex == 0
                  ? AppColors.primaryColor
                  : AppColors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/douaa.svg',
              color: currentIndex == 1
                  ? AppColors.primaryColor
                  : AppColors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/salat.svg',
              color: currentIndex == 2
                  ? AppColors.primaryColor
                  : AppColors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/bookmark.svg',
              color: currentIndex == 3
                  ? AppColors.primaryColor
                  : AppColors.grey,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 32,
              color: currentIndex == 4
                  ? AppColors.primaryColor
                  : AppColors.grey,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
