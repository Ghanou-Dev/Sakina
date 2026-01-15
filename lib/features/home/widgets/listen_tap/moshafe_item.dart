import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/apis/quran_audio/reciter_endpoint.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/models/moshafe_model.dart';
import 'package:sakina/features/home/pages/play_surah_page.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_surah_info.dart';

class MoshafeItem extends StatefulWidget {
  final MoshafeModel moshafe;
  final String reciterName;
  const MoshafeItem({
    super.key,
    required this.moshafe,
    required this.reciterName,
  });

  @override
  State<MoshafeItem> createState() => _MoshafeItemState();
}

class _MoshafeItemState extends State<MoshafeItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final List<ItemSurahInfo> surahInfoSuwars = context
        .read<HomeCubit>()
        .allSuwarsInfo;
    final List<String> suwarsUrl = ReciterEndpoint.getSpecialSurahAudioUrl(
      server: widget.moshafe.server,
      surahNumbers: widget.moshafe.surahList,
    );

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          splashColor: AppColors.silver.withAlpha(100),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(44),
            topRight: Radius.circular(44),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          child: Ink(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(44),
                topRight: Radius.circular(44),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20),
                Text(
                  widget.moshafe.name,
                  style: TextStyle(
                    fontFamily: amiri,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontSize: 26,
                  ),
                ),
                Gap(20),
                Text(
                  'Total surahs: ${widget.moshafe.surahTotal}',
                  style: TextStyle(
                    fontFamily: amiri,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                    fontSize: 20,
                  ),
                ),
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(
                        isOpen
                            ? Icons.keyboard_double_arrow_down_outlined
                            : Icons.keyboard_double_arrow_left_outlined,
                        size: 30,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Gap(4),
        isOpen
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.5,
                ////////////////////////////////////////////////////////////////
                child: ListView.builder(
                  itemCount: widget.moshafe.surahTotal,
                  itemBuilder: (context, index) {
                    final int surahIndex =
                        int.parse(
                          widget.moshafe.surahList[index],
                        ) -
                        1;
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PlaySurahPage(
                                  listSurahInfo: surahInfoSuwars,
                                  itemIndex: index,
                                  reciterName: widget.reciterName,
                                  moshafeModel: widget.moshafe,
                                  surahUrls: suwarsUrl,
                                ),
                              ),
                            );
                          },
                          splashColor: AppColors.silver.withAlpha(150),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                                  context.watch<AudioCubit>().currentIndex ==
                                          index &&
                                      widget.moshafe.name ==
                                          context
                                              .watch<AudioCubit>()
                                              .moshafeName &&
                                      context
                                              .watch<AudioCubit>()
                                              .currentReciter ==
                                          widget.reciterName
                                  ? AppColors.primaryColor.withAlpha(100)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(22),
                            ),

                            child: ItemSurahInfo(
                              surahName: surahInfoSuwars[surahIndex].surahName,
                              surahNameArabic:
                                  surahInfoSuwars[surahIndex].surahNameArabic,
                              surahNameArabicLong: surahInfoSuwars[surahIndex]
                                  .surahNameArabicLong,
                              surahNameTranslation: surahInfoSuwars[surahIndex]
                                  .surahNameTranslation,
                              revelationPlace:
                                  surahInfoSuwars[surahIndex].revelationPlace,
                              totalAyah: surahInfoSuwars[surahIndex].totalAyah,
                              index: int.parse(
                                widget.moshafe.surahList[index],
                              ),
                            ),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  },
                ),
              )
            : SizedBox(),
      ],
    );
  }
}
