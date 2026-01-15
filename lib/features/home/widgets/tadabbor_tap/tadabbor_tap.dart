import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_state.dart';
import 'package:sakina/features/home/pages/surah_page.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_surah_info.dart';

class Tadabbor extends StatefulWidget {
  const Tadabbor({super.key});

  @override
  State<Tadabbor> createState() => _TadabborState();
}

class _TadabborState extends State<Tadabbor>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeSurahLoaded) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return SurahPage(surah: state.surah);
              },
            ),
          );
          context.read<HomeCubit>().isTapped = false;
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HomeInfoSuwarsLoaded) {
          final infoSuwars = state.infoSuwars;
          return ListView.builder(
            itemCount: infoSuwars.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () async {
                      ////
                      if (context.read<HomeCubit>().isTapped) {
                        return;
                      }
                      context.read<HomeCubit>().isTapped = true;
                      ////
                      context.read<HomeCubit>().currentSurahName =
                          infoSuwars[index].surahName;
                      await context.read<HomeCubit>().getSpecialSurah(
                        surahNumber: index + 1,
                      );
                    },
                    child: ItemSurahInfo(
                      surahName: infoSuwars[index].surahName,
                      surahNameArabic: infoSuwars[index].surahNameArabic,
                      surahNameArabicLong:
                          infoSuwars[index].surahNameArabicLong,
                      surahNameTranslation:
                          infoSuwars[index].surahNameTranslation,
                      revelationPlace: infoSuwars[index].revelationPlace,
                      totalAyah: infoSuwars[index].totalAyah,
                      index: index + 1,
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          );
        } else {
          final infoSuwars = context.read<HomeCubit>().allSuwarsInfo;
          return ListView.builder(
            itemCount: infoSuwars.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () async {
                      ////
                      if (context.read<HomeCubit>().isTapped) {
                        return;
                      }
                      context.read<HomeCubit>().isTapped = true;

                      ///
                      await context.read<HomeCubit>().getSpecialSurah(
                        surahNumber: index + 1,
                      );
                    },
                    splashColor: AppColors.silver.withAlpha(150),
                    borderRadius: BorderRadius.circular(20),
                    child: ItemSurahInfo(
                      surahName: infoSuwars[index].surahName,
                      surahNameArabic: infoSuwars[index].surahNameArabic,
                      surahNameArabicLong:
                          infoSuwars[index].surahNameArabicLong,
                      surahNameTranslation:
                          infoSuwars[index].surahNameTranslation,
                      revelationPlace: infoSuwars[index].revelationPlace,
                      totalAyah: infoSuwars[index].totalAyah,
                      index: index + 1,
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          );
        }
      },
    );
  }
}
