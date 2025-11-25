import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sakina/cubits/HomeCubit/home_cubit.dart';
import 'package:sakina/cubits/InternetCubit/internet_cubit.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/helpers/extansions.dart';
import 'package:sakina/pages/BottomBar/bookmark.dart';
import 'package:sakina/pages/BottomBar/hadith.dart';
import 'package:sakina/pages/BottomBar/settings.dart';
import 'package:sakina/pages/BottomBar/home_page.dart';
import 'package:sakina/pages/BottomBar/mawakit_salat.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  Future<void> loadData() async {
    if (await InternetConnection().hasInternetAccess) {
      await context.read<HomeCubit>().getAudioSuwars();
      await context.read<HomeCubit>().getTaffsirOfAllSuwars();
    }
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
              await context.read<HomeCubit>().getSuwars();
              loadData();
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
              'assets/icons/douaa.svg',
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
              'assets/icons/bookmark.svg',
              color: currentIndex == 3 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 32,
              color: currentIndex == 4 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
