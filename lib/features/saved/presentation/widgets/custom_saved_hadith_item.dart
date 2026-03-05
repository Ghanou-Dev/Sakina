import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/hadith/presentation/widgets/map_const.dart';
import 'package:sakina/features/saved/domain/entitys/saved_hadith_entity.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_hadith_cubit/saved_hadith_cubit.dart';
import 'package:share_plus/share_plus.dart';

class CustomSavedHadithItem extends StatefulWidget {
  final SavedHadithEntity savedHadith;
  const CustomSavedHadithItem({
    super.key,
    required this.savedHadith,
  });

  @override
  State<CustomSavedHadithItem> createState() => _CustomSavedHadithItemState();
}

class _CustomSavedHadithItemState extends State<CustomSavedHadithItem> {
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
                      widget.savedHadith.status.getWorld,
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
                    ShareParams(text: widget.savedHadith.hadithArabic),
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
              BlocBuilder<SavedHadithCubit, SavedHadithState>(
                builder: (context, state) {
                  final List<String> allSavedIds = state.savedIds;
                  return IconButton(
                    onPressed: () async {
                      if (allSavedIds.contains(
                        widget.savedHadith.hadithArabic,
                      )) {
                        await context.read<SavedHadithCubit>().removeHadith(
                          hadith: widget.savedHadith,
                        );
                      } else {
                        await context.read<SavedHadithCubit>().saveHadith(
                          hadith: widget.savedHadith,
                        );
                      }
                    },
                    icon: Icon(
                      allSavedIds.contains(
                            widget.savedHadith.hadithArabic,
                          )
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: AppColors.primaryColor,
                    ),
                  );
                },
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
                        widget.savedHadith.headingArabic ??
                            widget.savedHadith.chapterArabic!,
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
                      widget.savedHadith.hadithArabic,
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
                                widget.savedHadith.englishNarrator ?? '',
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
                                widget.savedHadith.hadithEnglish,
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
