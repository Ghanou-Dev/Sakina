import 'package:flutter/material.dart';
import 'package:sakina/core/constants/data_qurane_pages.dart';

class DisplayQuranePage extends StatefulWidget {
  final int index;
  const DisplayQuranePage({required this.index, super.key});

  @override
  State<DisplayQuranePage> createState() => _DisplayQuranePageState();
}

class _DisplayQuranePageState extends State<DisplayQuranePage> {
  List<int> numPages = [];

  @override
  void initState() {
    super.initState();
    int start = quranPages[widget.index + 1]!['start'];
    int end = quranPages[widget.index + 1]!['end'];
    numPages = List.generate(
      (end - start) + 1,
      (index) => start + index,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PageView.builder(
          reverse: true,
          itemCount: numPages.length,
          itemBuilder: (context, index) {
            return Image.asset(
              'assets/all_qurane_pages/${numPages[index]}.png',
              fit: BoxFit.fill,
              width: double.infinity,
              alignment: Alignment.center,
            );
          },
        ),
      ),
    );
  }
}
