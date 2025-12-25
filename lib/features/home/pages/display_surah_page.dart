import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/models/surah_model.dart';
import 'package:sakina/features/home/widgets/item_ayah.dart';
import 'package:visibility_detector/visibility_detector.dart';

class DisplaySurahPage extends StatefulWidget {
  final SurahModel surah;
  const DisplaySurahPage({
    required this.surah,
    super.key,
  });

  static const String pageRoute = 'desplaySurahPage';
  @override
  State<DisplaySurahPage> createState() => _DisplaySurahPageState();
}

class _DisplaySurahPageState extends State<DisplaySurahPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          widget.surah.surahNameArabic,
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: secondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/search.png'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/background.png',
                    width: double.infinity,
                    height: 257,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 25,
                    ),
                    Text(
                      widget.surah.surahNameArabic,
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                    Gap(10),
                    Text(
                      widget.surah.surahName,
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 8,
                      ),
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.surah.revelationPlace.toUpperCase(),
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Gap(4),
                        Text(
                          '.',
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(4),
                        Text(
                          '${widget.surah.english.length} VERSES',
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Gap(40),
                    SvgPicture.asset('assets/icons/bismi_allah.svg'),
                  ],
                ),
              ],
            ),
            Gap(30),
            Expanded(
              child: BodyOfSurah(
                surah: widget.surah,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyOfSurah extends StatefulWidget {
  final SurahModel surah;
  const BodyOfSurah({
    required this.surah,
    super.key,
  });

  @override
  State<BodyOfSurah> createState() => _BodyOfSurahState();
}

class _BodyOfSurahState extends State<BodyOfSurah> {
  late ScrollController scrollController;
  Timer? debounced;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      initialScrollOffset: getOffset(widget.surah.surahNameArabic),
    );
    scrollController.addListener(onScroll);
  }

  double getOffset(String surahName) {
    return context.read<HomeCubit>().getOffset(surahName);
  }

  void onScroll() {
    debounced?.cancel();
    debounced = Timer(Duration(milliseconds: 300), () {
      context.read<HomeCubit>().saveOffset(
        widget.surah.surahNameArabic,
        scrollController.offset,
      );
    });
  }

  @override
  void dispose() {
    debounced?.cancel();
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: widget.surah.arabic1.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            children: [
              VisibilityDetector(
                key: Key(widget.surah.english[index]),
                onVisibilityChanged: (info) {
                  if (info.visibleFraction >= 0.8) {
                    // change number ayah index
                  }
                },
                child: ItemAyah(
                  ayahNo: index + 1,
                  surahNo: widget.surah.surahNo,
                  surahName: widget.surah.surahName,
                  arabic1: widget.surah.arabic1[index],
                  arabic2: widget.surah.arabic2[index],
                  english: widget.surah.english[index],
                  onTapPlay: () async {
                    if (context.read<AudioCubit>().player.playerState.playing &&
                        context.read<HomeCubit>().ayahNumber == index + 1) {
                      await context.read<AudioCubit>().stop();
                      return;
                    }
                    await context.read<AudioCubit>().stop();
                    await context.read<HomeCubit>().getSpecialAyahAudio(
                      surahNo: widget.surah.surahNo,
                      ayahNo: index + 1,
                    );
                    final ayah = context.read<HomeCubit>().audioAyah;
                    await context.read<AudioCubit>().playSpecialAyah(
                      url: ayah.affasi.originalUrl,
                      surahName: widget.surah.surahName,
                      artist: ayah.affasi.reciter,
                    );
                  },
                ),
              ),
              Divider(),
            ],
          ),
        );
      },
    );
  }
}
