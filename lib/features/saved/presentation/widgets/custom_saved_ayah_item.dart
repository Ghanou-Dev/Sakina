import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/saved/domain/entitys/saved_ayah_entity.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_ayah_cubit/saved_ayah_cubit.dart';
import 'package:share_plus/share_plus.dart';

class CustomSavedAyahItem extends StatefulWidget {
  final SavedAyahEntity savedAyah;
  const CustomSavedAyahItem({
    super.key,
    required this.savedAyah,
  });

  @override
  State<CustomSavedAyahItem> createState() => _CustomSavedAyahItemState();
}

class _CustomSavedAyahItemState extends State<CustomSavedAyahItem> {
  bool isShow = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.savedAyah.surahArabicName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      backgroundColor: AppColors.primaryColor,
                      child: Text(
                        '${widget.savedAyah.ayahNumber}',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: poppins,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  ///// share button /////////////////////////////////////////////
                  IconButton(
                    onPressed: () async {
                      final ShareResult result = await SharePlus.instance.share(
                        ShareParams(text: widget.savedAyah.textArabic),
                      );

                      if (result.status == ShareResultStatus.success) {
                        debugPrint('Thank you for share the ayah');
                      }
                    },
                    icon: Icon(
                      Icons.share_outlined,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  /// Icon play button ///////////////////////////////////////////
                  StreamBuilder<PlayerState>(
                    stream: context.read<AudioCubit>().player.playerStateStream,
                    builder: (context, snapshot) {
                      final isPlaying =
                          context.watch<AudioCubit>().state.isPlaying &&
                          context.read<HomeCubit>().ayahNumber ==
                              widget.savedAyah.ayahNumber;

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
                                      surahNo: widget.savedAyah.surahNumber,
                                      ayahNo: widget.savedAyah.ayahNumber,
                                    );
                                final ayah = context
                                    .read<HomeCubit>()
                                    .audioAyah;
                                await context
                                    .read<AudioCubit>()
                                    .playSpecialAyah(
                                      url: ayah.affasi.originalUrl,
                                      surahName:
                                          widget.savedAyah.surahEnglishName,
                                      artist: ayah.affasi.reciter,
                                    );
                              },
                        icon:
                            isLoading &&
                                context.read<HomeCubit>().ayahNumber ==
                                    widget.savedAyah.ayahNumber
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
                  //// Saved button //////////////////////////////////////////////
                  BlocSelector<SavedAyahCubit, SavedAyahState, bool>(
                    selector: (state) {
                      return state.savedAyahsKeys.contains(
                        widget.savedAyah.textArabic,
                      );
                    },
                    builder: (context, state) {
                      return IconButton(
                        onPressed: () async {
                          state
                              ? context.read<SavedAyahCubit>().removeSavedAyah(
                                  ayah: SavedAyahEntity(
                                    surahNumber: widget.savedAyah.surahNumber,
                                    textArabic: widget.savedAyah.textArabic,
                                    textEnglish: widget.savedAyah.textEnglish,
                                    taffsir: widget.savedAyah.taffsir,
                                    ayahNumber: widget.savedAyah.ayahNumber,
                                    surahArabicName:
                                        widget.savedAyah.surahArabicName,
                                    surahEnglishName:
                                        widget.savedAyah.surahEnglishName,
                                  ),
                                )
                              : context.read<SavedAyahCubit>().saveAyah(
                                  ayah: SavedAyahEntity(
                                    surahNumber: widget.savedAyah.surahNumber,
                                    textArabic: widget.savedAyah.textArabic,
                                    textEnglish: widget.savedAyah.textEnglish,
                                    taffsir: widget.savedAyah.taffsir,
                                    ayahNumber: widget.savedAyah.ayahNumber,
                                    surahArabicName:
                                        widget.savedAyah.surahArabicName,
                                    surahEnglishName:
                                        widget.savedAyah.surahEnglishName,
                                  ),
                                );
                        },
                        icon: Icon(
                          state
                              ? Icons.bookmark
                              : Icons.bookmark_border_outlined,
                          color: AppColors.primaryColor,
                        ),
                      );
                    },
                  ),

                  /// taffsir ayah button ////////////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                      iconSize: 30,
                      color: AppColors.primaryColor,
                      onPressed: () {
                        setState(() {
                          isShow = !isShow;
                        });
                      },
                      icon: Icon(
                        isShow
                            ? Icons.keyboard_arrow_down_sharp
                            : Icons.keyboard_arrow_left_sharp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          /////////////////// texts //////////////////////////////////////////////
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              textDirection: TextDirection.rtl,
              children: [
                Expanded(
                  child: Text(
                    textDirection: TextDirection.rtl,
                    widget.savedAyah.textArabic,
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
                    widget.savedAyah.textEnglish,
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

          /// taffsir ////////////////////////////////////////////////////////////
          isShow
              ? Row(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.savedAyah.taffsir,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontFamily: uthmani,
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )
              : SizedBox(),
          Gap(20),
          Divider(),
        ],
      ),
    );
  }
}
