import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/cubits/internet_cubit.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/hadith/presentation/cubits/book_cubit/book_cubit.dart';
import 'package:sakina/features/home/cubit/ListenCubit/listen_cubit.dart';
import 'package:sakina/features/home/cubit/TaffsirCubit/taffsir_cubit.dart';
import 'package:sakina/features/home/pages/bottom_bar_page.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';

class Spalsh extends StatefulWidget {
  const Spalsh({super.key});

  @override
  State<Spalsh> createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        context.read<InternetCubit>().listenToConnectionChanges();
        context.read<HomeCubit>().getSuwarsInfo();
        context.read<ListenCubit>().getAllReciters();
        context.read<HomeCubit>().loadFihras();
        context.read<TaffsirCubit>().getTaffsir();
        // hadith feature
        context.read<BookCubit>().getAllBooks();
      }
    });
  }

  bool isDialogActive = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80),
              Text(
                'sakina'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 28,
                ),
              ),
              SizedBox(
                height: 15,
                width: double.infinity,
              ),
              Text(
                'learen_quran_and'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontSize: 18,
                  color: Color(0xff8789A3),
                ),
              ),
              Text(
                'recite_once_everyday'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontSize: 18,
                  color: Color(0xff8789A3),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Stack(
                clipBehavior: Clip.none,

                children: [
                  Image.asset(
                    'assets/images/image1.png',
                    fit: BoxFit.cover,
                    height: 450,
                    width: 314,
                  ),
                  Positioned(
                    bottom: -20,
                    left: 70,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Color(0xffF9B091),
                        ),
                        fixedSize: WidgetStatePropertyAll(
                          Size(185, 60),
                        ),
                      ),
                      onPressed: () async {
                        // Navigator.of(
                        //   context,
                        // ).pushReplacementNamed(BottomBarPage.pageRoute);
                      },
                      child:
                          Text(
                                'Started'.tr(context),
                                style: TextStyle(
                                  fontFamily: poppins,
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              .animate(
                                onPlay: (controller) {
                                  controller.repeat();
                                  Future.delayed(2100.ms, () {
                                    controller.stop();
                                    Navigator.of(
                                      context,
                                    ).pushReplacementNamed(
                                      BottomBarPage.pageRoute,
                                    );
                                  });
                                },
                              )
                              .fadeIn(
                                duration: 600.ms,
                                curve: Curves.easeInOut,
                              )
                              .then(
                                delay: 200.ms,
                              )
                              .fadeOut(
                                duration: 600.ms,
                                curve: Curves.easeInOut,
                              ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
