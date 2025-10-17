import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/pages/bottom_bar_page.dart';
import 'package:sakina/cubits/HomeCubit/home_cubit.dart';
import 'package:sakina/cubits/HomeCubit/home_state.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Text(
              'Sakina',
              style: TextStyle(
                fontFamily: poppins,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontSize: 28,
              ),
            ),
            SizedBox(
              height: 15,
              width: double.infinity,
            ),
            Text(
              'Learn Quran and',
              style: TextStyle(
                fontFamily: poppins,
                fontSize: 18,
                color: Color(0xff8789A3),
              ),
            ),
            Text(
              'Recite once everyday',
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
                      fixedSize: WidgetStatePropertyAll(Size(185, 60)),
                    ),
                    onPressed: () async {
                      await context.read<HomeCubit>().getSuwars();
                      await context.read<HomeCubit>().getAudioSuwars();
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(BottomBarPage.pageRoute);
                    },
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        if (state is HomeLoading) {
                          return Center(
                            child: SizedBox(
                              width: 26,
                              height: 26,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          );
                        } else {
                          return Text(
                            'Get Started',
                            style: TextStyle(
                              fontFamily: poppins,
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                      },
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
    );
  }
}
