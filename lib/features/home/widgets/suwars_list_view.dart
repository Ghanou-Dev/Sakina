import 'package:flutter/material.dart';
import 'package:sakina/features/home/models/reciter_chikh_model.dart';
import 'package:sakina/features/home/models/reciter_model.dart';
import 'package:sakina/features/home/pages/play_surah.dart';
import 'package:sakina/features/home/widgets/custom_item_surah.dart';

class SuwarsListView extends StatelessWidget {
  final List<CustomItemSurah> suwars;
  final List<ReciterModel> mushaf;
  final ReciterChikhModel chikh;
  final int index;
  const SuwarsListView({
    required this.suwars,
    required this.mushaf,
    required this.chikh,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mushaf[index].surah_list.length,
      itemBuilder: (context, surahIndex) {
        return Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return PlaySurah(
                        suwars: suwars,
                        surahFont: suwars[surahIndex],
                        surahAudio: mushaf[index],
                        chikh: chikh,
                        surahIndex: surahIndex,
                      );
                    },
                  ),
                );
              },
              child:
                  suwars[int.parse(
                        mushaf[index].surah_list[surahIndex],
                      ) -
                      1],
            ),
            Divider(color: Colors.grey.shade300),
          ],
        );
      },
    );
  }
}
