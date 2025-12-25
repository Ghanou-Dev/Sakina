import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';

class PlaySurah extends StatefulWidget {
  final int surahIndex;
  const PlaySurah({
    super.key,
    required this.surahIndex,
  });

  @override
  State<PlaySurah> createState() => _PlaySurahState();
}

class _PlaySurahState extends State<PlaySurah> {
  @override
  void initState() {
    super.initState();
    // play();
  }

  // Future<void> play() async {
  //   if (context.read<AudioCubit>().index != widget.surahIndex ||
  //       context.read<AudioCubit>().chikhName != widget.chikh.name) {
  //     await context.read<AudioCubit>().playSurah(
  //       initialIndex: widget.surahIndex,
  //       reciter: widget.surahAudio,
  //       suwars: widget.suwars,
  //       chikh: widget.chikh,
  //     );
  //   }
  // }

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
                        'widget.chikh.name',
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
            child: Text(
              ';;;;;;',
              style: TextStyle(
                fontFamily: poppins,
                fontWeight: FontWeight.bold,
                color: theredColor,
                fontSize: 24,
              ),
            ),
          ),

          Text(
            'surah: ;;;;',
            style: TextStyle(
              fontFamily: poppins,
              fontWeight: FontWeight.bold,
              color: secondaryColor,
              fontSize: 14,
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  '00:00',
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
                  onChanged: (value) {},
                  thumbColor: primaryColor,
                  max: 0,
                  value: 0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  '00:00',
                  style: TextStyle(
                    fontFamily: poppins,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: secondaryColor,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {},
                child: SvgPicture.asset('assets/icons/download.svg'),
              ),
              TextButton(
                onPressed: () async {},
                child: SvgPicture.asset('assets/icons/previous.svg'),
              ),
              IconButton(
                onPressed: () async {},
                icon: Icon(
                  Icons.play_circle_fill_rounded,
                  size: 68,
                  color: primaryColor,
                ),
              ),
              TextButton(
                onPressed: () async {},
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
