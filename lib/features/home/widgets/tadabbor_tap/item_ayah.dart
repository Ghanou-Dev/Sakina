import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/saved/domain/entitys/saved_ayah_entity.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_ayah_cubit/saved_ayah_cubit.dart';
import 'package:share_plus/share_plus.dart';

class ItemAyah extends StatefulWidget {
  final int ayahNo;
  final int surahNo;
  final String surahName;
  final String surahArabicName;
  final String arabic1;
  final String arabic2;
  final String english;
  final Widget iconButton;
  final String taffsir;
  const ItemAyah({
    super.key,
    required this.ayahNo,
    required this.surahNo,
    required this.surahName,
    required this.surahArabicName,
    required this.arabic1,
    required this.arabic2,
    required this.english,
    required this.iconButton,
    required this.taffsir,
  });

  @override
  State<ItemAyah> createState() => _ItemAyahState();
}

class _ItemAyahState extends State<ItemAyah> {
  @override
  void initState() {
    super.initState();
  }

  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      '${widget.ayahNo}',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: poppins,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                ///// share button /////////////////////////////////////////////
                IconButton(
                  onPressed: () async {
                    final ShareResult result = await SharePlus.instance.share(
                      ShareParams(text: widget.arabic1),
                    );

                    if (result.status == ShareResultStatus.success) {
                      log('Thank you for share the ayah');
                    }
                  },
                  icon: Icon(
                    Icons.share_outlined,
                    color: AppColors.primaryColor,
                  ),
                ),

                /// Icon play button ///////////////////////////////////////////
                widget.iconButton,
                //// Saved button //////////////////////////////////////////////
                BlocSelector<SavedAyahCubit, SavedAyahState, bool>(
                  selector: (state) {
                    return state.savedAyahsKeys.contains(widget.arabic1);
                  },
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () async {
                        state
                            ? context.read<SavedAyahCubit>().removeSavedAyah(
                                ayah: SavedAyahEntity(
                                  surahNumber: widget.surahNo,
                                  textArabic: widget.arabic1,
                                  textEnglish: widget.english,
                                  taffsir: widget.taffsir,
                                  ayahNumber: widget.ayahNo,
                                  surahArabicName: widget.surahArabicName,
                                  surahEnglishName: widget.surahName,
                                ),
                              )
                            : context.read<SavedAyahCubit>().saveAyah(
                                ayah: SavedAyahEntity(
                                  surahNumber: widget.surahNo,
                                  textArabic: widget.arabic1,
                                  textEnglish: widget.english,
                                  taffsir: widget.taffsir,
                                  ayahNumber: widget.ayahNo,
                                  surahArabicName: widget.surahArabicName,
                                  surahEnglishName: widget.surahName,
                                ),
                              );
                      },
                      icon: Icon(
                        state ? Icons.bookmark : Icons.bookmark_border_outlined,
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                ),

                /// taffsir ayah button ////////////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    iconSize: 30,
                    color: AppColors.primaryColor,
                    onPressed: () {
                      setState(() {
                        isShow = !isShow;
                      });
                    },
                    icon: Icon(
                      isShow
                          ? Icons.keyboard_arrow_down_sharp
                          : Icons.keyboard_arrow_left_sharp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        /////////////////// texts //////////////////////////////////////////////
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Expanded(
                child: Text(
                  textDirection: TextDirection.rtl,
                  widget.arabic1,
                  style: TextStyle(
                    fontFamily: uthmani,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.ltr,
            children: [
              Expanded(
                child: Text(
                  textDirection: TextDirection.ltr,
                  widget.english,
                  style: TextStyle(
                    fontFamily: poppins,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),

        /// taffsir ////////////////////////////////////////////////////////////
        isShow
            ? Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      widget.taffsir,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontFamily: uthmani,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              )
            : SizedBox(),
        Gap(20),
      ],
    );
  }
}
