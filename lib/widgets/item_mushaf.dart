import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/helpers/constants/fonts.dart';
import 'package:sakina/widgets/suwars_list_view.dart';

class ItemMushaf extends StatefulWidget {
  final SuwarsListView suwarsListItem;
  const ItemMushaf({
    required this.suwarsListItem,
    super.key,
  });

  @override
  State<ItemMushaf> createState() => _ItemMushafState();
}

class _ItemMushafState extends State<ItemMushaf> {
  late SuwarsListView suwarsList;
  @override
  void initState() {
    super.initState();
    suwarsList = widget.suwarsListItem;
  }

  bool showMushaf = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18.0),
      child: Column(
        children: [
          Divider(
            color: Colors.grey.shade300,
            thickness: 3,
          ),
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/images/background.png',
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 25,
                  ),
                  Text(
                    suwarsList.mushaf[suwarsList.index].name,
                    style: TextStyle(
                      fontFamily: amiri,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Gap(16),
                  Text(
                    'Total surahs: ${suwarsList.mushaf[suwarsList.index].surah_total}',
                    style: TextStyle(
                      fontFamily: amiri,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 4,
                right: 20,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      showMushaf = !showMushaf;
                    });
                  },
                  icon: Icon(
                    showMushaf
                        ? Icons.keyboard_arrow_down_sharp
                        : Icons.keyboard_arrow_left,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Divider(
            color: Colors.grey.shade300,
            thickness: 3,
          ),
          showMushaf
              ? Column(
                  children: [
                    SizedBox(
                      height: 440,
                      child: suwarsList,
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                      thickness: 3,
                    ),
                  ],
                )
              : SizedBox(height: 8),
        ],
      ),
    );
  }
}

