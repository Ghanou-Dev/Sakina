import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_state.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:share_plus/share_plus.dart';

class ItemAyah extends StatefulWidget {
  final int ayahNo;
  final int surahNo;
  final String surahName;
  final String arabic1;
  final String arabic2;
  final String english;
  final Function()? onTapPlay;

  const ItemAyah({
    super.key,
    required this.ayahNo,
    required this.surahNo,
    required this.surahName,
    required this.arabic1,
    required this.arabic2,
    required this.english,
    this.onTapPlay,
  });

  @override
  State<ItemAyah> createState() => _ItemAyahState();
}

class _ItemAyahState extends State<ItemAyah> {
  bool isFavoriet = false;
  @override
  void initState() {
    super.initState();
    // add value to the variables isFavoriet from cubit
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: primaryColor,
                    child: Text(
                      '${widget.ayahNo}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: poppins,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () async {
                    final ShareResult result = await SharePlus.instance.share(
                      ShareParams(text: widget.arabic1),
                    );

                    if (result.status == ShareResultStatus.success) {
                      log('Thank you for share the ayah');
                    }
                  },
                  icon: Icon(Icons.share_outlined, color: primaryColor),
                ),
                ////////////////////////////////////////////////////////////////
                BlocBuilder<AudioCubit, AudioState>(
                  builder: (context, state) {
                    final isPlaying =
                        state is AudioPlayingState &&
                        context.read<HomeCubit>().ayahNumber == widget.ayahNo;
                    return IconButton(
                      onPressed: widget.onTapPlay,
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow_outlined,
                        color: primaryColor,
                        size: 30,
                      ),
                    );
                  },
                ),
                ////////////////////////////////////////////////////////////////
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavoriet = !isFavoriet;
                    });
                  },
                  icon: Icon(
                    isFavoriet
                        ? Icons.bookmark
                        : Icons.bookmark_border_outlined,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Text(
                  textDirection: TextDirection.rtl,
                  widget.arabic1,
                  style: TextStyle(
                    fontFamily: uthmani,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Expanded(
                child: Text(
                  textDirection: TextDirection.ltr,
                  widget.english,
                  style: TextStyle(
                    fontFamily: poppins,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
