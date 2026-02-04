import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/hadith/domain/entitys/chapter_entity.dart';
import 'package:sakina/features/hadith/domain/entitys/hadith_entity.dart';
import 'package:sakina/features/hadith/presentation/cubits/hadith_cubit/hadith_cubit.dart';
import 'package:sakina/features/hadith/presentation/map_const.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:share_plus/share_plus.dart';
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

class CustomHadithItem extends StatefulWidget {
  final ChapterEntity chapter;
  final HadithEntity hadith;
  const CustomHadithItem({
    super.key,
    required this.hadith,
    required this.chapter,
  });

  @override
  State<CustomHadithItem> createState() => _CustomHadithItemState();
}

class _CustomHadithItemState extends State<CustomHadithItem> {
  bool showTranslate = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    border: Border.all(color: AppColors.primaryColor),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.hadith.status.getWorld,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontFamily: amiri,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () async {
                  await SharePlus.instance.share(
                    ShareParams(text: widget.hadith.hadithArabic),
                  );
                  // if (result.status == ShareResultStatus.success) {
                  //   print('the text was sharing successfully');
                  // }
                },
                icon: Icon(
                  Icons.share_outlined,
                  color: AppColors.primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  color: AppColors.primaryColor,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    showTranslate = !showTranslate;
                  });
                },
                icon: Icon(
                  showTranslate
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.keyboard_arrow_left_outlined,
                  size: 30,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.hadith.headingArabic ??
                            widget.chapter.chapterArabic,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: uthmani,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.silver,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 8,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.hadith.hadithArabic,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: uthmani,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          showTranslate
              ? Container(
                  decoration: BoxDecoration(
                    color: AppColors.silver,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      left: 8,
                      bottom: 12,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.hadith.englishNarrator ?? '',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: uthmani,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.orange,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.hadith.hadithEnglish,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontFamily: uthmani,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.deepBlue,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox.shrink(),
          Divider(),
        ],
      ),
    );
  }
}
