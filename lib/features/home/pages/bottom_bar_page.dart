import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/core/cubits/InternetCubit/internet_cubit.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/saved/pages/bookmark.dart';
import 'package:sakina/features/hadith/pages/hadith.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {});
  }

  int currentIndex = 0;
  List<Widget> pages = [
    HomePage(),
    Hadith(),
    MawakitSalat(),
    Bookmark(),
    Settings(),
  ];

  void _showMessage(String message, bool isConnected) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isConnected ? Colors.greenAccent : Colors.redAccent,
        dismissDirection: DismissDirection.startToEnd,
        duration: isConnected ? Duration(seconds: 3) : Duration(seconds: 3),

        content: Text(
          message,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InternetCubit, InternetState>(
        listener: (context, state) async {
          if (state is InternetConnectionState) {
            if (state.isConnected) {
              _showMessage('Connected'.tr(context), true);
              await context.read<HomeCubit>().getSuwarsInfo();
            } else {
              _showMessage('no_internet'.tr(context), false);
            }
          }
        },
        child: IndexedStack(
          index: currentIndex,
          children: pages,
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
