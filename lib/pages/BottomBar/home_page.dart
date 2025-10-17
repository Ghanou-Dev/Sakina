import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/cubits/AudioCubit/audio_cubit.dart';
import 'package:sakina/cubits/AudioCubit/audio_state.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/widgets/custom_tap_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String pageRoute = 'homePage';

  @override
  Widget build(BuildContext context) {
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
        leading: TextButton(
          onPressed: () {},
          child: Image.asset(
            'assets/images/menu.png',
            height: 24,
            width: 24,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Asslamu Alaikum',
              style: TextStyle(
                fontFamily: poppins,
                fontSize: 18,
                color: theredColor,
              ),
            ),
            Gap(16),
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
      ),
    );
  }
}
