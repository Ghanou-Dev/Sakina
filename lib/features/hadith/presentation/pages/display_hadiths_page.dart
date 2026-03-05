import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/hadith/domain/entitys/chapter_entity.dart';
import 'package:sakina/features/hadith/domain/entitys/hadith_entity.dart';
import 'package:sakina/features/hadith/presentation/cubits/hadith_cubit/hadith_cubit.dart';
import 'package:sakina/features/hadith/presentation/widgets/custom_hadith_item.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shimmer/shimmer.dart';

class DisplayHadithsPage extends StatefulWidget {
  final ChapterEntity chapter;
  const DisplayHadithsPage({super.key, required this.chapter});

  @override
  State<DisplayHadithsPage> createState() => _DisplayHadithsPageState();
}

class _DisplayHadithsPageState extends State<DisplayHadithsPage> {
  // constrollers
  FocusNode node = FocusNode();
  SearchController searchController = SearchController();
  // دالة لنزع التشكيل
  String noTashkiil({required String text}) {
    final namat = RegExp(
      r'[\u0617-\u061A\u064B-\u0652\u0670\u0640]',
    );
    return text.replaceAll(namat, '');
  }

  ItemScrollController itemScrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        title: Text(
          widget.chapter.chapterEnglish,
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<HadithCubit, HadithState>(
        builder: (context, state) {
          if (state is HadithLoaded) {
            List<HadithEntity> allHadiths = state.allHadiths;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10,
                    bottom: 16,
                  ),
                  child: Focus(
                    focusNode: node,
                    child: SearchAnchor.bar(
                      barHintText: 'Search for hadith ',
                      barHintStyle: WidgetStatePropertyAll(
                        TextStyle(fontWeight: FontWeight.bold),
                      ),
                      viewBackgroundColor: AppColors.white,
                      viewSide: BorderSide(color: AppColors.primaryColor),
                      barBackgroundColor: WidgetStatePropertyAll(
                        Colors.deepPurple.shade50,
                      ),
                      barElevation: WidgetStatePropertyAll(6),
                      barTrailing: [
                        IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: Icon(Icons.cancel_outlined),
                        ),
                      ],

                      searchController: searchController,
                      suggestionsBuilder: (context, controller) {
                        List<String> allHadithsText = state.allHadiths
                            .map((item) => item.hadithArabic)
                            .toList();
                        final filtred = allHadithsText.where(
                          (hadith) {
                            return noTashkiil(
                              text: hadith,
                            ).toLowerCase().contains(
                              controller.text.toLowerCase(),
                            );
                          },
                        ).toList();
                        return filtred.map(
                          (hadithText) {
                            return ListTile(
                              onTap: () {
                                controller.closeView(hadithText);
                                FocusScope.of(
                                  context,
                                ).requestFocus(FocusNode());

                                // go to hadith index
                                int hadithIndex = allHadiths.indexWhere(
                                  (hadith) => hadith.hadithArabic == hadithText,
                                );
                                if (hadithIndex != -1) {
                                  itemScrollController.scrollTo(
                                    index: hadithIndex,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeIn,
                                  );
                                }
                              },
                              title: Text(
                                hadithText,
                                style: TextStyle(
                                  fontFamily: amiri,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      onClose: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemCount: allHadiths.length,
                    itemScrollController: itemScrollController,
                    itemBuilder: (context, index) {
                      return CustomHadithItem(
                        hadith: allHadiths[index],
                        chapter: widget.chapter,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            //
            return Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        final size = MediaQuery.of(context).size;
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: size.width / 5,
                                      height: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: AppColors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  left: 8,
                                  right: 8,
                                  bottom: 2.0,
                                ),
                                child: Container(
                                  height: 50,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 8,
                                  bottom: 8,
                                  top: 2.0,
                                ),
                                child: Container(
                                  width: size.width,
                                  height: size.height / 3.6,
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
