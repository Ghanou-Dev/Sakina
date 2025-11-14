import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sakina/cubits/InternetCheckerCubit/internet_checker_cubit.dart';
import 'package:sakina/cubits/InternetCheckerCubit/internet_checker_state.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<InternetCheckerCubit>().checkConnection();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool _isClickGetStarted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<InternetCheckerCubit, InternetCheckerState>(
            listener: (context, state) {
              if (state is InternetCheckerCheck) {
                if (state.isConnection && state.isLow == false) {
                  _connected(isConnected: true, message: 'Connected');
                } else if (state.isConnection && state.isLow == true) {
                  _connectionStateDialog(
                    'Internet connection is wake! Please try again later ',
                  );
                } else {
                  if (_isClickGetStarted == false) {
                    _connectionStateDialog(
                      'Please Check Your Internet Connection And Try Again',
                    );
                  }
                }
              }
            },
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
                          _getStarted();
                        },
                        child: BlocConsumer<HomeCubit, HomeState>(
                          listener: (context, state) {
                            if (state is HomeFailure) {
                              _connectionStateDialog(
                                state.message,
                              );
                            }
                          },
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
        ),
      ),
    );
  }

  void _connectionStateDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _connected({required String message, required bool isConnected}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isConnected ? Colors.greenAccent : Colors.redAccent,
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

  Future<void> _getStarted() async {
    ///////////// 1
    final connectionState = context
        .read<InternetCheckerCubit>()
        .connectionState;
    if (connectionState == InternetConnectionStatus.disconnected) {
      _connectionStateDialog(
        'Please Check your internet connection and try again',
      );
    } else if (connectionState == InternetConnectionStatus.connected) {
      _isClickGetStarted = true;
      await context.read<HomeCubit>().getSuwars();
      Navigator.of(
        context,
      ).pushReplacementNamed(BottomBarPage.pageRoute);
    } else {
      try {
        await context.read<HomeCubit>().getSuwars();
        Navigator.of(
          context,
        ).pushReplacementNamed(BottomBarPage.pageRoute);
      } catch (e) {
        _connectionStateDialog(
          'Your internet connection is wake! try again later',
        );
      }
    }
  }
}
