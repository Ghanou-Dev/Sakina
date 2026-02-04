import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/hadith/domain/entitys/book_entity.dart';
import 'package:sakina/features/hadith/domain/entitys/chapter_entity.dart';
import 'package:sakina/features/hadith/presentation/cubits/chapter_cubit/chapter_cubit.dart';
import 'package:sakina/features/hadith/presentation/cubits/hadith_cubit/hadith_cubit.dart';
import 'package:sakina/features/hadith/presentation/pages/display_hadiths_page.dart';
import 'package:shimmer/shimmer.dart';

class DisplayChaptersPage extends StatefulWidget {
  final BookEntity book;
  const DisplayChaptersPage({super.key, required this.book});

  @override
  State<DisplayChaptersPage> createState() => _DisplayChaptersPageState();
}

class _DisplayChaptersPageState extends State<DisplayChaptersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primaryColor,
          ),
        ),
        title: Text(
          widget.book.bookName,
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),
      body: BlocBuilder<ChapterCubit, ChapterState>(
        builder: (context, state) {
          if (state is ChapterLoaded) {
            List<ChapterEntity> allChapters = state.allChapters;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: allChapters.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          // get all Hadiths
                          context.read<HadithCubit>().getAllHadiths(
                            bookSlug: allChapters[index].bookSlug,
                            chapterNumber: int.parse(
                              allChapters[index].chapterNumber,
                            ),
                          );
                          context.read<ChapterCubit>().selectedChapterName =
                              allChapters[index].chapterEnglish;
                          setState(() {});
                          // navigat to Display Hadithes page
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DisplayHadithsPage(
                                chapter: allChapters[index],
                              ),
                            ),
                          );
                        },
                        splashColor: AppColors.silver,
                        borderRadius: BorderRadius.circular(20),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: CustomChapter(
                            isSelected:
                                context
                                    .read<ChapterCubit>()
                                    .selectedChapterName ==
                                allChapters[index].chapterEnglish,
                            chapter: allChapters[index],
                          ),
                        ),
                      ),
                      Divider(),
                    ],
                  );
                },
              ),
            );
          } else {
            //
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade400,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 20,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),

                        Divider(),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class CustomChapter extends StatefulWidget {
  final ChapterEntity chapter;
  final bool isSelected;
  const CustomChapter({
    super.key,
    required this.chapter,
    required this.isSelected,
  });

  @override
  State<CustomChapter> createState() => _CustomChapterState();
}

class _CustomChapterState extends State<CustomChapter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        title: Text(
          widget.chapter.chapterArabic,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: poppins,
            color: AppColors.black,
          ),
        ),
        subtitle: Text(
          widget.chapter.chapterEnglish,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: poppins,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: AppColors.primaryColor,
        ),
        splashColor: AppColors.silver,
        selected: widget.isSelected,
      ),
    );
  }
}
