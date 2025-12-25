import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_state.dart';
import 'package:sakina/features/home/pages/display_surah_page.dart';
import 'package:sakina/features/home/widgets/item_surah_info.dart';

class CustomTabBar extends StatefulWidget {
  final int length;
  const CustomTabBar({required this.length, super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with AutomaticKeepAliveClientMixin {
  @override
  get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultTabController(
      length: widget.length,
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            padding: EdgeInsets.only(bottom: 8),
            labelPadding: EdgeInsets.only(bottom: 15, top: 10),
            indicatorAnimation: TabIndicatorAnimation.elastic,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            splashBorderRadius: BorderRadius.circular(15),
            isScrollable: false,
            unselectedLabelColor: secondaryColor,

            tabs: [
              Text(
                'Tadabbor'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Liten'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Read'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Taffsir'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Tadabbor(),
                Listen(),
                Read(),
                Taffsir(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                return DisplaySurahPage(surah: state.surah);
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
                      //
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
        }
      },
    );
  }
}

class Listen extends StatefulWidget {
  const Listen({super.key});

  @override
  State<Listen> createState() => _ListenState();
}

class _ListenState extends State<Listen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Center(
      child: Text('Listen'),
    );
  }
}

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<Read> createState() => _ReadState();
}

class _ReadState extends State<Read> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          final infoSuwars = context.read<HomeCubit>().allSuwarsInfo;
          return ListView.builder(
            itemCount: infoSuwars.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {},
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

class Taffsir extends StatefulWidget {
  const Taffsir({super.key});

  @override
  State<Taffsir> createState() => _TaffsirState();
}

class _TaffsirState extends State<Taffsir> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        } else {
          final infoSuwars = context.read<HomeCubit>().allSuwarsInfo;
          return ListView.builder(
            itemCount: infoSuwars.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {},
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
