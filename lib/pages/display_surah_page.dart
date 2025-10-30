import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sakina/cubits/HomeCubit/home_cubit.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/widgets/custom_item_surah.dart';
import 'package:sakina/widgets/custom_item_ayah.dart';

class DisplaySurahPage extends StatefulWidget {
  final CustomItemSurah surah;
  final CustomItemSurah surahEnglish;
  const DisplaySurahPage({
    required this.surah,
    required this.surahEnglish,
    super.key,
  });

  static const String pageRoute = 'desplaySurahPage';

  @override
  State<DisplaySurahPage> createState() => _DisplaySurahPageState();
}

class _DisplaySurahPageState extends State<DisplaySurahPage> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          widget.surah.name,
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: secondaryColor),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/search.png'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/background.png',
                    width: double.infinity,
                    height: 257,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 25,
                    ),
                    Text(
                      widget.surah.name,
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 26,
                      ),
                    ),
                    Gap(10),
                    Text(
                      widget.surah.englishName,
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.normal,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 60.0,
                        vertical: 8,
                      ),
                      child: Divider(
                        color: Colors.white,
                        thickness: 0.5,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.surah.revelationType.toUpperCase(),
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Gap(4),
                        Text(
                          '.',
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(4),
                        Text(
                          '${widget.surah.ayahs.length} VERSES',
                          style: TextStyle(
                            fontFamily: poppins,
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Gap(40),
                    SvgPicture.asset('assets/icons/bismi_allah.svg'),
                  ],
                ),
              ],
            ),
            Gap(30),
            Expanded(
              child: BodyOfSurah(
                surah: widget.surah,
                surahEnglish: widget.surahEnglish,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BodyOfSurah extends StatefulWidget {
  final CustomItemSurah surah;
  final CustomItemSurah surahEnglish;
  const BodyOfSurah({
    required this.surah,
    required this.surahEnglish,
    super.key,
  });

  @override
  State<BodyOfSurah> createState() => _BodyOfSurahState();
}

class _BodyOfSurahState extends State<BodyOfSurah> {
  late ScrollController scrollController;
  Timer? debounced;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      initialScrollOffset: getOffset(widget.surah.name),
    );
    scrollController.addListener(onScroll);
  }

  double getOffset(String surahName) {
    return context.read<HomeCubit>().getOffset(surahName);
  }

  void onScroll() {
    debounced?.cancel();
    debounced = Timer(Duration(milliseconds: 300), () {
      context.read<HomeCubit>().saveOffset(
        widget.surah.name,
        scrollController.offset,
      );
    });
  }

  @override
  void dispose() {
    debounced?.cancel();
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: widget.surah.ayahs.length,
      itemBuilder: (context, index) {
        return CustomItemAyah(
          surah: widget.surah,
          ayah: widget.surah.ayahs[index],
          ayahEnglish: widget.surahEnglish.ayahs[index],
        );
      },
    );
  }
}
