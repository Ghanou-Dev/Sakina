import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_state.dart';
import 'package:sakina/features/home/cubit/ListenCubit/listen_cubit.dart';
import 'package:sakina/features/home/models/reciter_model.dart';
import 'package:sakina/features/home/pages/display_all_moshafs.dart';
import 'package:sakina/features/home/widgets/custom_tap_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String pageRoute = 'homePage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(
      //   backgroundColor: AppColors.white,
      //   title: Text(
      //     'sakina'.tr(context),
      //     style: TextStyle(
      //       fontFamily: poppins,
      //       fontWeight: FontWeight.bold,
      //       color: AppColors.primaryColor,
      //     ),
      //   ),
      //   actions: [
      //     // Row(
      //     //   mainAxisAlignment: MainAxisAlignment.end,
      //     //   children: [
      //     //     SizedBox(
      //     //       width: MediaQuery.of(context).size.width / 1.5,
      //     //       height: 50,
      //     //       child: Focus(
      //     //         focusNode: focusNode,
      //     //         child: SearchAnchor.bar(
      //     //           barHintText: 'Search for resiter',
      //     //           barTrailing: [
      //     //             IconButton(
      //     //               onPressed: () {
      //     //                 setState(() {
      //     //                   searchController.clear();
      //     //                 });
      //     //               },
      //     //               icon: Icon(
      //     //                 Icons.cancel_outlined,
      //     //               ),
      //     //             ),
      //     //           ],
      //     //           barBackgroundColor: WidgetStatePropertyAll(AppColors.white),
      //     //           barElevation: WidgetStatePropertyAll(0),
      //     //           viewBackgroundColor: AppColors.white,
      //     //           //
      //     //           searchController: searchController,
      //     //           suggestionsBuilder: (context, controller) {
      //     //             // filtred
      //     //             final filtredList = resiterList.where(
      //     //               (resiter) {
      //     //                 return resiter.name.contains(controller.text);
      //     //               },
      //     //             ).toList();
      //     //             if (filtredList.isNotEmpty) {
      //     //               return filtredList.map((resiter) {
      //     //                 return ListTile(
      //     //                   title: Text(resiter.name),
      //     //                   onTap: () {
      //     //                     controller.closeView(resiter.name);
      //     //                     FocusScope.of(context).unfocus();
      //     //                     Navigator.of(context).push(
      //     //                       MaterialPageRoute(
      //     //                         builder: (context) =>
      //     //                             DisplayAllMoshafs(reciter: resiter),
      //     //                       ),
      //     //                     );
      //     //                   },
      //     //                 );
      //     //               }).toList();
      //     //             } else {
      //     //               return [
      //     //                 ListTile(
      //     //                   title: Text('Search in arabic !'),
      //     //                   onTap: () {
      //     //                     controller.closeView('No result !');
      //     //                     FocusScope.of(context).unfocus();
      //     //                   },
      //     //                 ),
      //     //               ];
      //     //             }
      //     //           },
      //     //           onClose: () {
      //     //             FocusScope.of(context).requestFocus(FocusNode());
      //     //           },
      //     //         ),
      //     //       ),
      //     //     ),
      //     //     SizedBox(width: 14),
      //     //   ],
      //     // ),
      //   ],
      // ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BodyHomePage(),
      ),
    );
  }
}

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({super.key});

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  bool isDialogActive = false;

  // search anchir bar
  SearchController searchController = SearchController();
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final List<ReciterModel> resiterList = context
        .read<ListenCubit>()
        .recitersList;
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Focus(
              focusNode: focusNode,
              child: SearchAnchor.bar(
                barHintText: 'Search for resiter',
                barTrailing: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        searchController.clear();
                      });
                    },
                    icon: Icon(
                      Icons.cancel_outlined,
                    ),
                  ),
                ],
                barBackgroundColor: WidgetStatePropertyAll(AppColors.white),
                barElevation: WidgetStatePropertyAll(0),
                viewBackgroundColor: AppColors.white,
                //
                searchController: searchController,
                suggestionsBuilder: (context, controller) {
                  // filtred
                  final filtredList = resiterList.where(
                    (resiter) {
                      return resiter.name.contains(controller.text);
                    },
                  ).toList();

                  if (filtredList.isNotEmpty) {
                    return filtredList.map((resiter) {
                      return ListTile(
                        title: Text(resiter.name),
                        onTap: () {
                          controller.closeView(resiter.name);
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  DisplayAllMoshafs(reciter: resiter),
                            ),
                          );
                        },
                      );
                    }).toList();
                  } else {
                    return [
                      ListTile(
                        title: Text('Search in arabic !'),
                        onTap: () {
                          controller.closeView('No result !');
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ];
                  }
                },
                onClose: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
              ),
            ),
          ),

          //////////////////////////////////////////////////////////////////////
          Container(
            width: double.infinity,
            height: 131,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xffDF98FA),
                  Color(0xff9055FF),
                ],
              ),
            ),
            child: Stack(
              clipBehavior: Clip.antiAlias,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.menu_book_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            Gap(5),
                            Text(
                              'Last Read'.tr(context),
                              style: TextStyle(
                                fontFamily: poppins,
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(20),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeSurahLoaded) {
                            return Text(
                              state.surah.surahName,
                              style: TextStyle(
                                fontFamily: poppins,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            );
                          } else {
                            return Text(
                              context.read<HomeCubit>().currentSurahName,
                              style: TextStyle(
                                fontFamily: poppins,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            );
                          }
                        },
                      ),
                      Gap(5),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          if (state is HomeChangeAyahNumber) {
                            return Text(
                              'Number of last ayah :  ${state.ayahNumber}',
                              style: TextStyle(
                                fontFamily: poppins,
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return Text(
                              'Number of last ayah :  ${context.read<HomeCubit>().currentAyahNumber}',
                              style: TextStyle(
                                fontFamily: poppins,
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 26,
                  left: 172,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 180,
                    height: 120,
                  ),
                ),
              ],
            ),
          ),
          Gap(20),
          Expanded(
            child: CustomTabBar(length: 3),
          ),
        ],
      ),
    );
  }
}
