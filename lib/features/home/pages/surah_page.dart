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
import 'package:sakina/features/home/cubit/HomeCubit/home_state.dart';
import 'package:sakina/features/home/cubit/TaffsirCubit/taffsir_cubit.dart';
import 'package:sakina/features/home/models/taffsir_surah_model.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_ayah.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_schimmer_ayah.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_surah_info.dart';
import 'package:shimmer/shimmer.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SurahPage extends StatefulWidget {
  final ItemSurahInfo surahInfo;
  const SurahPage({
    required this.surahInfo,
    super.key,
  });

  static const String pageRoute = 'desplaySurahPage';
  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  late ScrollController scrollController;
  Timer? debounced;
  int positionIndex = 0;
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    scrollController = ScrollController(
      initialScrollOffset: getOffset(widget.surahInfo.surahNameArabic),
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
        widget.surahInfo.surahNameArabic,
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
    final size = MediaQuery.of(context).size;
    final state = context.watch<HomeCubit>().state;
    if (state is HomeInitial ||
        state is HomeLoading ||
        state is HomeSurahLoading) {
      return Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade400,
                      child: Container(
                        height: size.height / 28,
                        width: size.width / 3,
                        decoration: BoxDecoration(color: AppColors.white),
                      ),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade200,
                      highlightColor: Colors.grey.shade400,
                      child: Container(
                        height: size.height / 28,
                        width: size.width / 12,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    height: size.height / 3.4,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.circular(20),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ItemSchimmerAyah(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    final surah = context.watch<HomeCubit>().specialSurah;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          context.read<HomeCubit>().changeAyahNumber(ayahNumber: positionIndex);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          title: Text(
            widget.surahInfo.surahNameArabic,
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
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: size.height / 3.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/images/background.png',

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
                          widget.surahInfo.surahNameArabic,
                          style: TextStyle(
                            fontFamily: poppins,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                        Gap(10),
                        Text(
                          widget.surahInfo.surahName,
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
                              widget.surahInfo.revelationPlace.toUpperCase(),
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
                              '${context.watch<HomeCubit>().specialSurah.english.length} VERSES',
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
              ),
              SliverToBoxAdapter(
                child: Gap(30),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: surah.english.length,
                  (context, index) {
                    final List<TaffsirSurahModel> taffsirSuwars = context
                        .read<TaffsirCubit>()
                        .tafsirList;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Column(
                        children: [
                          VisibilityDetector(
                            key: Key(surah.english[index]),
                            onVisibilityChanged: (info) {
                              if (info.visibleFraction >= 0.7) {
                                positionIndex = index + 1;
                              }
                            },
                            child: BlocSelector<AudioCubit, AudioState, bool>(
                              selector: (state) {
                                return state.isPlaying &&
                                    context.read<HomeCubit>().ayahNumber ==
                                        index + 1;
                              },
                              builder: (context, state) {
                                return ItemAyah(
                                  ayahNo: index + 1,
                                  surahNo: surah.surahNo,
                                  surahName: surah.surahName,
                                  surahArabicName: surah.surahNameArabic,
                                  arabic1: surah.arabic1[index],
                                  arabic2: surah.arabic2[index],
                                  english: surah.english[index],
                                  taffsir: taffsirSuwars[surah.surahNo - 1]
                                      .ayahs[index]
                                      .text,
                                  iconButton: StreamBuilder<PlayerState>(
                                    stream: context
                                        .read<AudioCubit>()
                                        .player
                                        .playerStateStream,
                                    builder: (context, snapshot) {
                                      final stateAudio =
                                          snapshot.data?.processingState;
                                      final isLoading =
                                          stateAudio ==
                                              ProcessingState.loading ||
                                          stateAudio ==
                                              ProcessingState.buffering;
                                      return IconButton(
                                        onPressed: isLoading
                                            ? null
                                            : () async {
                                                if (state) {
                                                  await context
                                                      .read<AudioCubit>()
                                                      .stop();
                                                  return;
                                                }
                                                await context
                                                    .read<AudioCubit>()
                                                    .stop();
                                                await context
                                                    .read<HomeCubit>()
                                                    .getSpecialAyahAudio(
                                                      surahNo: surah.surahNo,
                                                      ayahNo: index + 1,
                                                    );
                                                final ayah = context
                                                    .read<HomeCubit>()
                                                    .audioAyah;
                                                await context
                                                    .read<AudioCubit>()
                                                    .playSpecialAyah(
                                                      url: ayah
                                                          .affasi
                                                          .originalUrl,
                                                      surahName:
                                                          surah.surahName,
                                                      artist:
                                                          ayah.affasi.reciter,
                                                    );
                                              },
                                        icon:
                                            isLoading &&
                                                context
                                                        .read<HomeCubit>()
                                                        .ayahNumber ==
                                                    index + 1
                                            ? SizedBox(
                                                height: 20,
                                                width: 20,
                                                child:
                                                    CircularProgressIndicator(
                                                      color: AppColors
                                                          .primaryColor,
                                                    ),
                                              )
                                            : Icon(
                                                state
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
