import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_state.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/home/pages/display_chikh_suwars.dart';
import 'package:sakina/features/home/pages/display_qurane_page.dart';
import 'package:sakina/features/home/pages/display_surah_page.dart';
import 'package:sakina/features/home/pages/display_taffsir_of_surah_page.dart';

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
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeDataLoaded) {
                return ListView.builder(
                  controller: scrollController,
                  itemCount: state.customItemSuwars.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context.read<AudioCubit>().lastSurahRead =
                                state.customItemSuwars[index].englishName;

                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplaySurahPage(
                                  surah: state.customItemSuwars[index],
                                  surahEnglish:
                                      state.customItemSuwarsEnglish[index],
                                ),
                              ),
                            );
                          },
                          child: state.customItemSuwars[index],
                        ),
                        Divider(color: Colors.grey.shade300),
                      ],
                    );
                  },
                );
              } else if (state is HomeTimeoutFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/no-wifi.png',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        "Please Check your internet connection and try again"
                            .tr(context),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
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
    return Builder(
      builder: (context) {
        return BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeDataLoaded) {
              if (state.reciterChikhs.isNotEmpty &&
                  state.customItemSuwars.isNotEmpty) {
                return ListView.builder(
                  itemCount: state.reciterChikhs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayChikhSuwars(
                                  chikhItem: state.reciterChikhs[index],
                                  suwars: state.customItemSuwars,
                                ),
                              ),
                            );
                          },
                          child: state.reciterChikhs[index],
                        ),
                        Divider(color: Colors.grey.shade300),
                      ],
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            } else if (state is HomeTimeoutFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/no-wifi.png',
                      width: 150,
                      height: 150,
                    ),
                    Text(
                      "Please Check your internet connection and try again".tr(
                        context,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      },
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
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeDataLoaded) {
                if (state.customItemSuwars.isNotEmpty) {
                  final suwarsData = state.customItemSuwars;
                  return ListView.builder(
                    itemCount: suwarsData.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DisplayQuranePage(
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: suwarsData[index],
                          ),
                          Divider(color: Colors.grey.shade300),
                        ],
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else if (state is HomeTimeoutFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/no-wifi.png',
                        width: 150,
                        height: 150,
                      ),
                      Text(
                        "Please Check your internet connection and try again"
                            .tr(context),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
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
    // final suwarsDataText = context.read<HomeCubit>().suwars;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeDataLoaded) {
          if (state.taffsirOffAllSuwars.isNotEmpty) {
            final suwarsDataText = state.customItemSuwars;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: suwarsDataText.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DisplayTaffsirOfSurahPage(
                                        surahText: suwarsDataText[index],
                                        surahTaffsir:
                                            state.taffsirOffAllSuwars[index],
                                      ),
                                ),
                              );
                            },
                            child: suwarsDataText[index],
                          ),
                          Divider(),
                        ],
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        } else if (state is HomeTimeoutFailure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/no-wifi.png',
                  width: 150,
                  height: 150,
                ),
                Text(
                  "Please Check your internet connection and try again".tr(
                    context,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
