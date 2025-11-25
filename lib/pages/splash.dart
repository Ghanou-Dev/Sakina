import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sakina/cubits/InternetCubit/internet_cubit.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/constants/fonts.dart';
import 'package:sakina/helpers/extansions.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<InternetCubit>().checkConnection();
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
          child: BlocListener<InternetCubit, InternetState>(
            listener: (context, state) {
              if (state is InternetConnectionState) {
                if (!mounted) return;

                if (state.isConnected == false) {
                  _connectionStateDialog('no_internet'.tr(context));
                }
                if (state.isConnected && isDialogActive) {
                  isDialogActive = false;
                  Navigator.pop(context);
                }
              }
            },
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
                    color: primaryColor,
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
                          fixedSize: WidgetStatePropertyAll(Size(185, 60)),
                        ),
                        onPressed: () async {
                          if (mounted) {
                            _getStarted(context);
                          }
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
                                'get_started'.tr(context),
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
        ),
      ),
    );
  }

  void _connectionStateDialog(String message) {
    if (!mounted) return;
    isDialogActive = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(30),
              Image.asset(
                'assets/images/no-wifi.png',
                height: 70,
                width: 70,
              ),
              Gap(30),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () async {
                isDialogActive = false;
                Navigator.of(context).pop();
              },
              child: Text(
                'ok'.tr(context),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _getStarted(BuildContext context) async {
    // final connectionState = context.read<InternetCubit>().isConnected;
    final bool isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected == false) {
      _connectionStateDialog(
        'Please Check your internet connection and try again'.tr(context),
      );
    } else {
      try {
        await context.read<HomeCubit>().getSuwars();
        Navigator.of(
          context,
        ).pushReplacementNamed(BottomBarPage.pageRoute);
      } catch (e) {
        _connectionStateDialog(
          'Your internet connection is wake! try again later'.tr(context),
        );
      }
    }
  }
}
