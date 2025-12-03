import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_state.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/models/reciter_chikh_model.dart';
import 'package:sakina/features/home/models/reciter_model.dart';
import 'package:sakina/features/home/widgets/custom_item_surah.dart';

class PlaySurah extends StatefulWidget {
  final List<CustomItemSurah> suwars;
  final CustomItemSurah surahFont;
  final ReciterModel surahAudio;
  final ReciterChikhModel chikh;
  final int surahIndex;
  const PlaySurah({
    super.key,
    required this.suwars,
    required this.surahFont,
    required this.surahAudio,
    required this.chikh,
    required this.surahIndex,
  });

  @override
  State<PlaySurah> createState() => _PlaySurahState();
}

class _PlaySurahState extends State<PlaySurah> {
  @override
  void initState() {
    super.initState();
    play();
  }

  Future<void> play() async {
    if (context.read<AudioCubit>().index != widget.surahIndex ||
        context.read<AudioCubit>().chikhName != widget.chikh.name) {
      await context.read<AudioCubit>().playSurah(
        initialIndex: widget.surahIndex,
        reciter: widget.surahAudio,
        suwars: widget.suwars,
        chikh: widget.chikh,
      );
    }
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
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios_new,

                    color: primaryColor,
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
                        widget.chikh.name,
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
                    color: primaryColor,
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
            child: BlocBuilder<AudioCubit, AudioState>(
              builder: (context, state) {
                if (state is AudioLoaded) {
                  return Text(
                    '${widget.suwars[state.index].englishName} (${widget.suwars[state.index].name.replaceFirst('سُورَةُ', '')})',
                    style: TextStyle(
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                      color: theredColor,
                      fontSize: 24,
                    ),
                  );
                } else {
                  return Text(
                    '${widget.surahFont.englishName} (${widget.surahFont.name.replaceFirst('سُورَةُ', '')})',
                    style: TextStyle(
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                      color: theredColor,
                      fontSize: 24,
                    ),
                  );
                }
              },
            ),
          ),
          BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              if (state is AudioLoaded) {
                return Text(
                  'surah: ${widget.suwars[state.index].number}',
                  style: TextStyle(
                    fontFamily: poppins,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                    fontSize: 14,
                  ),
                );
              } else {
                return Text(
                  'surah: ${widget.surahFont.number}',
                  style: TextStyle(
                    fontFamily: poppins,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                    fontSize: 14,
                  ),
                );
              }
            },
          ),
          Spacer(),
          StreamBuilder<Duration>(
            stream: context.read<AudioCubit>().position,
            builder: (context, snapshot) {
              final duration = context.read<AudioCubit>().duration;
              final position = snapshot.data ?? Duration.zero;
              //////
              String formatTime(Duration d) {
                String toDigits(int n) => n.toString().padLeft(2, '0');
                String hours = toDigits(d.inHours.remainder(60));
                String minutes = toDigits(d.inMinutes.remainder(60));
                String secondes = toDigits(d.inSeconds.remainder(60));
                return hours == '00'
                    ? '$minutes:$secondes'
                    : '$hours:$minutes:$secondes';
              }

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Text(
                      formatTime(position),
                      style: TextStyle(
                        fontFamily: poppins,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: Slider(
                      thumbColor: primaryColor,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds
                          .clamp(0, duration.inSeconds)
                          .toDouble(),
                      onChanged: (value) {
                        context.read<AudioCubit>().seek(
                          position: Duration(seconds: value.toInt()),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Text(
                      formatTime(duration),
                      style: TextStyle(
                        fontFamily: poppins,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor,
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
                onPressed: () {},
                child: SvgPicture.asset('assets/icons/download.svg'),
              ),
              TextButton(
                onPressed: () async {
                  await context.read<AudioCubit>().previous();
                },
                child: SvgPicture.asset('assets/icons/previous.svg'),
              ),
              BlocBuilder<AudioCubit, AudioState>(
                builder: (context, state) {
                  if (state is AudioLoaded) {
                    return IconButton(
                      onPressed: () async {
                        if (state.isPlaying) {
                          await context.read<AudioCubit>().pause();
                        } else {
                          await context.read<AudioCubit>().resume();
                        }
                      },
                      icon: Icon(
                        state.isPlaying
                            ? Icons.pause_circle_filled_rounded
                            : Icons.play_circle_fill_rounded,
                        size: 68,
                        color: primaryColor,
                      ),
                    );
                  } else {
                    return IconButton(
                      onPressed: () async {
                        await context.read<AudioCubit>().playSurah(
                          initialIndex: widget.surahIndex,
                          reciter: widget.surahAudio,
                          suwars: widget.suwars,
                          chikh: widget.chikh,
                        );
                      },
                      icon: Icon(
                        Icons.play_circle_fill_rounded,
                        size: 68,
                        color: primaryColor,
                      ),
                    );
                  }
                },
              ),
              TextButton(
                onPressed: () async {
                  await context.read<AudioCubit>().next();
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
