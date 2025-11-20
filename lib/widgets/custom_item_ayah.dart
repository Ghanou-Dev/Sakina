import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/constants/fonts.dart';
import 'package:sakina/models/ayah_model.dart';
import 'package:sakina/cubits/AudioCubit/audio_cubit.dart';
import 'package:sakina/cubits/AudioCubit/audio_state.dart';
import 'package:sakina/widgets/custom_item_surah.dart';

class CustomItemAyah extends StatefulWidget {
  final CustomItemSurah surah;
  final AyahModel ayah;
  final AyahModel ayahEnglish;
  const CustomItemAyah({
    required this.surah,
    required this.ayah,
    required this.ayahEnglish,
    super.key,
  });

  @override
  State<CustomItemAyah> createState() => _CustomItemAyahState();
}

class _CustomItemAyahState extends State<CustomItemAyah> {
  bool isFavoriet = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xfff3f3f4),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: primaryColor,
                radius: 15,
                child: Text(
                  '${widget.ayah.numberInSurah}',
                  style: TextStyle(fontFamily: poppins, color: Colors.white),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.share,
                  color: primaryColor,
                ),
              ),
              BlocBuilder<AudioCubit, AudioState>(
                builder: (context, state) {
                  if (state is AudioLoaded &&
                      state.currentAyah == widget.ayah.numberInSurah) {
                    return IconButton(
                      onPressed: () async {
                        if (state.isPlaying) {
                          await context.read<AudioCubit>().pause();
                        } else {
                          context.read<AudioCubit>().currentAyah =
                              widget.ayah.numberInSurah;
                          await context.read<AudioCubit>().playAyah(
                            ayah: widget.ayah,
                            surah: widget.surah,
                          );
                        }
                      },
                      icon: Icon(
                        state.isPlaying == true
                            ? Icons.pause
                            : Icons.play_arrow_outlined,
                        color: primaryColor,
                        size: 30,
                      ),
                    );
                  } else {
                    return IconButton(
                      onPressed: () async {
                        context.read<AudioCubit>().currentAyah =
                            widget.ayah.numberInSurah;
                        context.read<AudioCubit>().lastSurahRead =
                            widget.surah.englishName;
                        // play aya sound
                        await context.read<AudioCubit>().playAyah(
                          ayah: widget.ayah,
                          surah: widget.surah,
                        );
                      },
                      icon: Icon(
                        Icons.play_arrow_outlined,
                        color: primaryColor,
                        size: 30,
                      ),
                    );
                  }
                },
              ),
              IconButton(
                onPressed: () {
                  // نقوم بتخزين بيانات الاية داخل هايف
                  // عند العرض نقوم بمقارنة بيانات الاية بالايات المخزنة في هايف لنحدد قيمة isFavoriet
                  // في صفحة المفضل نعرض قائمة الايات المخزنة في هايف

                  setState(() {
                    isFavoriet = !isFavoriet;
                  });
                },
                icon: Icon(
                  isFavoriet ? Icons.bookmark : Icons.bookmark_border,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ),
        Gap(40),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.rtl,
          children: [
            Expanded(
              child: Text(
                widget.ayah.text,
                textDirection: TextDirection.rtl,
                softWrap: true,
                style: TextStyle(
                  fontFamily: amiri,
                  fontWeight: FontWeight.bold,
                  color: theredColor,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        Gap(30),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          textDirection: TextDirection.ltr,
          children: [
            Expanded(
              child: Text(
                widget.ayahEnglish.text,
                textDirection: TextDirection.ltr,
                softWrap: true,
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.normal,
                  color: theredColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        Gap(20),
        Divider(color: Colors.grey.shade300),
        Gap(25),
      ],
    );
  }
}
