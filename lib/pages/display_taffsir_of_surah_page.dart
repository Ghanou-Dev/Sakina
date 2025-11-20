import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/cubits/HomeCubit/home_cubit.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/constants/fonts.dart';
import 'package:sakina/widgets/custom_item_surah.dart';

class DisplayTaffsirOfSurahPage extends StatefulWidget {
  final CustomItemSurah surahText;
  final CustomItemSurah surahTaffsir;
  const DisplayTaffsirOfSurahPage({
    required this.surahText,
    required this.surahTaffsir,
    super.key,
  });

  @override
  State<DisplayTaffsirOfSurahPage> createState() =>
      _DisplayTaffsirOfSurahPageState();
}

class _DisplayTaffsirOfSurahPageState extends State<DisplayTaffsirOfSurahPage> {
  late ScrollController scrollController;
  Timer? debounced;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(
      initialScrollOffset: getOffset(widget.surahText.englishName),
    );
    scrollController.addListener(onScroll);
  }

  double getOffset(String surahKey) {
    final offset = context.read<HomeCubit>().getOffset(surahKey);
    return offset;
  }

  void onScroll() {
    debounced?.cancel();
    debounced = Timer(Duration(milliseconds: 300), () {
      context.read<HomeCubit>().saveOffset(
        widget.surahText.englishName,
        scrollController.offset,
      );
    });
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    debounced?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Taffsir of surah ${widget.surahText.englishName}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: poppins,
            color: primaryColor,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget.surahTaffsir.ayahs.length,
                itemBuilder: (context, index) {
                  return CustomTaffsirOfSurah(
                    ayahTaffsir: widget.surahTaffsir.ayahs[index].text,
                    ayahText: widget.surahText.ayahs[index].text,
                    number: index += 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTaffsirOfSurah extends StatelessWidget {
  final String ayahText;
  final String ayahTaffsir;
  final int number;
  const CustomTaffsirOfSurah({
    required this.ayahText,
    required this.ayahTaffsir,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: BoxBorder.all(color: forthColor, width: 2),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ayah N° : $number',
                    style: TextStyle(
                      fontFamily: poppins,
                      fontWeight: FontWeight.bold,
                      color: forthColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      ayahText,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: fiveColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      ayahTaffsir,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: theredColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, bottom: 16.0),
          child: Divider(
            color: forthColor,
            thickness: 2,
          ),
        ),
      ],
    );
  }
}
