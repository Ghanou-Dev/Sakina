import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/hadith/domain/entitys/book_entity.dart';
import 'package:sakina/features/hadith/presentation/cubits/chapter_cubit/chapter_cubit.dart';
import 'package:sakina/features/hadith/presentation/pages/display_chapters_page.dart';

class CustomHadithBook extends StatelessWidget {
  final BookEntity book;
  const CustomHadithBook({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ChapterCubit>().getAllChapters(
          bookSlug: book.bookSlug,
        );
        Navigator.of(
          context,
        ).push(
          MaterialPageRoute(
            builder: (context) => DisplayChaptersPage(
              book: book,
            ),
          ),
        );
      },
      splashColor: Colors.black26,
      borderRadius: BorderRadius.circular(20),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.deepBlue, width: 1),
          boxShadow: [
            BoxShadow(
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
          image: DecorationImage(
            image: AssetImage('assets/images/image12.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 14.0,
                horizontal: 8,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      book.bookName,
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBlue,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
