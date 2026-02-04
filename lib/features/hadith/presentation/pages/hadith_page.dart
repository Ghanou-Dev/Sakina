import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/hadith/presentation/cubits/book_cubit/book_cubit.dart';
import 'package:sakina/features/hadith/presentation/widgets/custom_hadith_book.dart';
import 'package:sakina/features/hadith/presentation/widgets/custom_hadith_lafita.dart';
import 'package:shimmer/shimmer.dart';

class Hadith extends StatelessWidget {
  const Hadith({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Hadith'.tr(context),
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: SvgPicture.asset(
              'assets/icons/mosque-02.svg',
              colorFilter: ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: CustomHadithLafita(),
            ),
          ),
          Gap(2),
          BlocBuilder<BookCubit, BookState>(
            builder: (context, state) {
              if (state is BookLoaded) {
                final allBooks = state.allBooks;
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: allBooks.length,
                    itemBuilder: (context, index) {
                      if (index == 7 || index == 8) {
                        return SizedBox.shrink();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomHadithBook(
                            book: allBooks[index],
                          ),
                        );
                      }
                    },
                  ),
                );
              } else {
                //
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: 6,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade400,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );

                // return Center(
                //   child: CircularProgressIndicator(
                //     color: AppColors.primaryColor,
                //   ),
                // );
              }
            },
          ),
        ],
      ),
    );
  }
}
