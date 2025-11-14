import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sakina/cubits/AudioCubit/audio_cubit.dart';
import 'package:sakina/cubits/AudioCubit/audio_state.dart';
import 'package:sakina/cubits/InternetCheckerCubit/internet_checker_cubit.dart';
import 'package:sakina/cubits/InternetCheckerCubit/internet_checker_state.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/widgets/custom_tap_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String pageRoute = 'homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sakina',
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/search.png'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BodyHomePage(),
      ),
    );
  }
}

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({super.key});

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  bool isConnectionBack = false;
  bool isDialogActive = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCheckerCubit, InternetCheckerState>(
      listener: (context, state) {
        if (state is InternetCheckerCheck) {
          isConnectionBack = state.isConnection;
          if (state.isConnection == false) {
            _showDialog('No internet!\nPlease try again later');
          }
          if (isConnectionBack && isDialogActive) {
            Navigator.pop(context);
            _showMessage('Connected');
          }
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 131,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffDF98FA),
                  Color(0xff9055FF),
                ],
              ),
            ),
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            Gap(5),
                            Text(
                              'Last Read',
                              style: TextStyle(
                                fontFamily: poppins,
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(20),
                      BlocBuilder<AudioCubit, AudioState>(
                        builder: (context, state) {
                          if (state is AudioLastRead) {
                            return Text(
                              state.lastRead,
                              style: TextStyle(
                                fontFamily: poppins,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            );
                          } else {
                            return Text(
                              context.read<AudioCubit>().lastSurahRead,
                              style: TextStyle(
                                fontFamily: poppins,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            );
                          }
                        },
                      ),
                      Gap(5),
                      BlocBuilder<AudioCubit, AudioState>(
                        builder: (context, state) {
                          if (state is AudioLastRead) {
                            return Text(
                              'Ayah N° :  ${state.ayahNumber}',
                              style: TextStyle(
                                fontFamily: poppins,
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return Text(
                              'Ayah N° :  ${context.read<AudioCubit>().currentAyah}',
                              style: TextStyle(
                                fontFamily: poppins,
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 26,
                  left: 172,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 180,
                    height: 120,
                  ),
                ),
              ],
            ),
          ),
          Gap(20),
          Expanded(
            child: CustomTabBar(
              length: 4,
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog(String message) {
    isConnectionBack =
        context.read<InternetCheckerCubit>().connectionState ==
        InternetConnectionStatus.connected;
    isDialogActive = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                await SystemNavigator.pop();
              },
              child: Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.greenAccent,
        dismissDirection: DismissDirection.startToEnd,

        content: Text(
          message,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
    );
  }
}
