import 'package:flutter/material.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/home/widgets/listen_tap/listen_tap.dart';
import 'package:sakina/features/home/widgets/read_tap.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/tadabbor_tap.dart';
import 'package:sakina/features/home/widgets/taffsir_tap.dart';

class CustomTabBar extends StatefulWidget {
  final int length;
  const CustomTabBar({required this.length, super.key});

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with AutomaticKeepAliveClientMixin {
  @override
  get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return DefaultTabController(
      length: widget.length,
      child: Column(
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            padding: EdgeInsets.only(bottom: 8),
            labelPadding: EdgeInsets.only(bottom: 15, top: 10),
            indicatorAnimation: TabIndicatorAnimation.elastic,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            splashBorderRadius: BorderRadius.circular(15),
            isScrollable: false,
            unselectedLabelColor: AppColors.grey,

            tabs: [
              Text(
                'Tadabbor'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Liten'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Read'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                'Taffsir'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Tadabbor(),
                Listen(),
                Read(),
                Taffsir(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
