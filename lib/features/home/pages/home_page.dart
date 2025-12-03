import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_state.dart';
import 'package:sakina/core/cubits/InternetCubit/internet_cubit.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/home/widgets/custom_tap_bar.dart';

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
          'sakina'.tr(context),
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
  bool isDialogActive = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (context, state) {
        if (state is InternetConnectionState) {
          if (state.isConnected == false) {
            _showDialog(
              'Please Check your internet connection and try again'.tr(context),
            );
          }
          if (state.isConnected && isDialogActive) {
            isDialogActive = false;
            Navigator.of(context).pop();
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
                              'Last Read'.tr(context),
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
                              '${'Ayah N° :  '.tr(context)}${state.ayahNumber}',
                              style: TextStyle(
                                fontFamily: poppins,
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return Text(
                              '${'Ayah N° :  '.tr(context)}${context.read<AudioCubit>().currentAyah}',
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
    isDialogActive = true;
    showDialog(
      barrierDismissible: false,
      context: context,
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
                style: TextStyle(fontWeight: FontWeight.bold),
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
}
