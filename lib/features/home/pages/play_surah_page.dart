import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_state.dart';
import 'package:sakina/features/home/models/moshafe_model.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_surah_info.dart';

class PlaySurahPage extends StatefulWidget {
  final int itemIndex;
  final String reciterName;
  final MoshafeModel moshafeModel;
  final List<ItemSurahInfo> listSurahInfo;
  final List<String> surahUrls;
  const PlaySurahPage({
    super.key,
    required this.itemIndex,
    required this.reciterName,
    required this.moshafeModel,
    required this.surahUrls,
    required this.listSurahInfo,
  });

  @override
  State<PlaySurahPage> createState() => _PlaySurahPageState();
}

class _PlaySurahPageState extends State<PlaySurahPage> {
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.itemIndex;
    play();
  }

  Future<void> play() async {
    if (context.read<AudioCubit>().currentIndex == widget.itemIndex &&
        context.read<AudioCubit>().moshafeName == widget.moshafeModel.name &&
        context.read<AudioCubit>().currentReciter == widget.reciterName) {
      return;
    }
    await context.read<AudioCubit>().playSpecialMoshafe(
      moshafe: widget.moshafeModel,
      reciterName: widget.reciterName,
      suwarsUrls: widget.surahUrls,
      index: widget.itemIndex,
      surahInfo: widget.listSurahInfo,
    );
  }

  String formatTime({required Duration total}) {
    String towDigit(int t) => t.toString().padLeft(2, '0');
    String hour = towDigit(total.inSeconds ~/ 3600);
    String minuts = towDigit((total.inSeconds % 3600) ~/ 60);
    String secondes = towDigit(total.inSeconds % 60);
    return hour == '00' ? '$minuts:$secondes' : '$hour:$minuts:$secondes';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 40.0,
                  left: 10,
                ),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              Stack(
                children: [
                  Image.asset('assets/images/rectangle.png'),
                  SizedBox(
                    width: 260,
                    height: 200,
                    child: Center(
                      child: Text(
                        widget.reciterName,
                        style: TextStyle(
                          fontFamily: poppins,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 14,
                    left: 40,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 180,
                      height: 180,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0, right: 10),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.favorite_border,
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20.0,
              left: 20,
              top: 30,
              bottom: 4,
            ),
            /////////////////////////////////////////////////////////////////////
            child: BlocBuilder<AudioCubit, AudioState>(
              builder: (context, state) {
                currentIndex = state.index;
                return Text(
                  '${widget.listSurahInfo[int.parse(widget.moshafeModel.surahList[currentIndex]) - 1].surahName} ( ${widget.listSurahInfo[int.parse(widget.moshafeModel.surahList[currentIndex]) - 1].surahNameArabic} )',
                  style: TextStyle(
                    fontFamily: poppins,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepBlue,
                    fontSize: 24,
                  ),
                );
              },
            ),
          ),

          BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              currentIndex = state.index;
              return Text(
                'surah: ${widget.listSurahInfo[int.parse(widget.moshafeModel.surahList[currentIndex]) - 1].totalAyah}',
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                  fontSize: 14,
                ),
              );
            },
          ),
          Spacer(),
          BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      formatTime(total: state.position),
                      style: TextStyle(
                        fontFamily: poppins,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: Slider(
                      thumbColor: AppColors.primaryColor,
                      min: 0,
                      max: context
                          .watch<AudioCubit>()
                          .total
                          .inSeconds
                          .toDouble(),
                      value: state.position.inSeconds
                          .clamp(
                            0,
                            context
                                .watch<AudioCubit>()
                                .total
                                .inSeconds
                                .toDouble(),
                          )
                          .toDouble(),
                      onChanged: (value) {
                        context.read<AudioCubit>().seek(
                          Duration(seconds: value.toInt()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      formatTime(total: context.watch<AudioCubit>().total),
                      style: TextStyle(
                        fontFamily: poppins,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {},
                child: SvgPicture.asset('assets/icons/download.svg'),
              ),
              // previous button
              TextButton(
                onPressed: () async {
                  if (context.read<AudioCubit>().currentIndex > 0) {
                    await context.read<AudioCubit>().previous();
                    log(
                      'CURRENT INDEX : ${context.read<AudioCubit>().currentIndex}',
                    );
                  } else {
                    return;
                  }
                },
                child: SvgPicture.asset('assets/icons/previous.svg'),
              ),
              BlocBuilder<AudioCubit, AudioState>(
                builder: (context, state) {
                  bool isPlaying = state.isPlaying;
                  return AbsorbPointer(
                    absorbing: state.isLoading,
                    child: StreamBuilder<PlayerState>(
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
                                  isPlaying
                                      ? await context
                                            .read<AudioCubit>()
                                            .player
                                            .pause()
                                      : await context
                                            .read<AudioCubit>()
                                            .player
                                            .play();
                                },
                          icon: isLoading
                              ? Container(
                                  color: Colors.transparent,
                                  height: 68,
                                  width: 68,
                                  child: Center(
                                    child: CircleAvatar(
                                      radius: 28,
                                      backgroundColor: AppColors.primaryColor,
                                      child: SizedBox(
                                        width: 26,
                                        height: 26,
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Icon(
                                  isPlaying
                                      ? Icons.pause_circle_filled
                                      : Icons.play_circle_fill_rounded,
                                  size: 68,
                                  color: AppColors.primaryColor,
                                ),
                        );
                      },
                    ),
                  );
                },
              ),
              // next button
              TextButton(
                onPressed: () async {
                  if (context.read<AudioCubit>().currentIndex < 113) {
                    await context.read<AudioCubit>().next();
                    log(
                      'CURRENT INDEX : ${context.read<AudioCubit>().currentIndex}',
                    );
                  } else {
                    return;
                  }
                },
                child: SvgPicture.asset('assets/icons/next.svg'),
              ),
              TextButton(
                onPressed: () {},
                child: SvgPicture.asset('assets/icons/shuffle.svg'),
              ),
            ],
          ),
          Gap(50),
        ],
      ),
    );
  }
}
