import 'package:flutter/material.dart';
import 'package:sakina/constants/colors.dart';
import 'package:sakina/constants/fonts.dart';
import 'package:sakina/widgets/custom_item_surah.dart';
import 'package:sakina/widgets/item_mushaf.dart';
import 'package:sakina/widgets/reciter_chikh_item.dart';
import 'package:sakina/widgets/suwars_list_view.dart';

class DisplayChikhSuwars extends StatelessWidget {
  final ReciterChikhItem chikhItem;
  final List<CustomItemSurah> suwars;
  const DisplayChikhSuwars({
    required this.chikhItem,
    required this.suwars,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          chikhItem.chikh.name,
          style: TextStyle(
            fontFamily: amiri,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        leading: TextButton(
          onPressed: () {},
          child: Image.asset(
            'assets/images/menu.png',
            height: 24,
            width: 24,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Image.asset('assets/images/search.png'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                'Availabel Recitations',
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  color: theredColor,
                  fontSize: 22,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: chikhItem.chikh.moshaf.length,
                itemBuilder: (context, index) {
                  return ItemMushaf(
                    suwarsListItem: SuwarsListView(
                      mushaf: chikhItem.chikh.moshaf,
                      suwars: suwars,
                      chikh: chikhItem.chikh,
                      index: index,
                    ),
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
