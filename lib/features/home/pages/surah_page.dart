import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_state.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/models/surah_model.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_ayah.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SurahPage extends StatefulWidget {
  final SurahModel surah;
  const SurahPage({
    required this.surah,
    super.key,
  });

  static const String pageRoute = 'desplaySurahPage';
  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
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
            color: AppColors.primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: AppColors.grey),
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
                  if (info.visibleFraction >= 0.7) {
                    // change number ayah index
                    context.read<HomeCubit>().changeAyahNumber(
                      ayahNumber: index + 1,
                    );
                  }
                },
                child: BlocBuilder<AudioCubit, AudioState>(
                  builder: (context, state) {
                    final isPlaying =
                        state.isPlaying &&
                        context.read<HomeCubit>().ayahNumber == index + 1;
                    return ItemAyah(
                      ayahNo: index + 1,
                      surahNo: widget.surah.surahNo,
                      surahName: widget.surah.surahName,
                      arabic1: widget.surah.arabic1[index],
                      arabic2: widget.surah.arabic2[index],
                      english: widget.surah.english[index],
                      //////////////////////////////////////////////////////////////
                      iconButton: StreamBuilder<PlayerState>(
                        stream: context
                            .read<AudioCubit>()
                            .player
                            .playerStateStream,
                        builder: (context, snapshot) {
                          final state = snapshot.data?.processingState;
                          final isLoading =
                              state == ProcessingState.loading ||
                              state == ProcessingState.buffering;
                          return IconButton(
                            onPressed: isLoading
                                ? null
                                : () async {
                                    if (isPlaying) {
                                      await context.read<AudioCubit>().stop();
                                      return;
                                    }
                                    await context.read<AudioCubit>().stop();
                                    await context
                                        .read<HomeCubit>()
                                        .getSpecialAyahAudio(
                                          surahNo: widget.surah.surahNo,
                                          ayahNo: index + 1,
                                        );
                                    final ayah = context
                                        .read<HomeCubit>()
                                        .audioAyah;
                                    await context
                                        .read<AudioCubit>()
                                        .playSpecialAyah(
                                          url: ayah.affasi.originalUrl,
                                          surahName: widget.surah.surahName,
                                          artist: ayah.affasi.reciter,
                                        );
                                  },
                            icon:
                                isLoading &&
                                    context.read<HomeCubit>().ayahNumber ==
                                        index + 1
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  )
                                : Icon(
                                    isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow_outlined,
                                    color: AppColors.primaryColor,
                                    size: 30,
                                  ),
                          );
                        },
                      ),
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
