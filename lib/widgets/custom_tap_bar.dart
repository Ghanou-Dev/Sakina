import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/cubits/HomeCubit/home_cubit.dart';
import 'package:sakina/cubits/HomeCubit/home_state.dart';
import 'package:sakina/pages/display_chikh_suwars.dart';
import 'package:sakina/pages/display_surah_page.dart';

class CustomTabBar extends StatefulWidget {
  final int length;
  const CustomTabBar({required this.length, super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with AutomaticKeepAliveClientMixin {
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollController2 = ScrollController();

  // need for automaticKeepAli..
  @override
  get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    // need for automaticKeepAli..
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
                'Surah',
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Liten',
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Read',
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Tafsir',
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
                Column(
                  children: [
                    Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoadedSuwars) {
                            return ListView.builder(
                              controller: scrollController,
                              itemCount: state.customItemSuwars.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => DisplaySurahPage(
                                              surah:
                                                  state.customItemSuwars[index],
                                              surahEnglish: state
                                                  .customItemSuwarsEnglish[index],
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
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                ListView.builder(
                  controller: scrollController2,
                  itemCount: context.read<HomeCubit>().reciterChikhs.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DisplayChikhSuwars(
                                  chikhItem: context
                                      .read<HomeCubit>()
                                      .reciterChikhs[index],
                                  suwars: context.read<HomeCubit>().suwars,
                                ),
                              ),
                            );
                          },
                          child: context.read<HomeCubit>().reciterChikhs[index],
                        ),
                        Divider(color: Colors.grey.shade300),
                      ],
                    );
                  },
                ),

                Container(child: Center(child: Text('...'))),
                Container(child: Center(child: Text('...'))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
