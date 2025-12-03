import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';

class MawakitSalat extends StatelessWidget {
  const MawakitSalat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        title: Text(
          'Mawaqit Al-Salat'.tr(context),
          style: TextStyle(
            fontFamily: poppins,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: [
                  CurrentSalatItem(),
                  Gap(10),
                  TodaysPriyerTimeList(),
                ],
              ),
            ),
            Gap(10),
            ChangeLocationItem(),
          ],
        ),
      ),
    );
  }
}

class CurrentSalatItem extends StatelessWidget {
  const CurrentSalatItem({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 3.8,
      width: size.width,
      decoration: BoxDecoration(
        color: Color(0xffdd96fa),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  style: ButtonStyle(
                    iconSize: WidgetStatePropertyAll<double?>(32),
                    backgroundColor: WidgetStatePropertyAll(
                      primaryColor,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(16),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.wb_sunny_outlined,
                    color: Colors.white,
                  ),
                ),
                Gap(10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The following prayer',
                      style: TextStyle(
                        fontFamily: amiri,
                        fontWeight: FontWeight.normal,
                        color: theredColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Duher',
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.bold,
                        color: theredColor,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              height: size.height / 7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Prayer Time',
                    style: TextStyle(
                      fontFamily: amiri,
                      color: forthColor,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '12:09',
                    style: TextStyle(
                      fontFamily: poppins,
                      color: theredColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(color: Colors.grey.shade300),
                  ),
                  Text(
                    '00 : 10 : 35',
                    style: TextStyle(
                      fontFamily: poppins,
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Time remaining',
                    style: TextStyle(
                      fontFamily: amiri,
                      color: forthColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TodaysPriyerTimeList extends StatelessWidget {
  const TodaysPriyerTimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Today\'s Payer Times',
            style: TextStyle(
              fontFamily: poppins,
              fontWeight: FontWeight.bold,
              color: primaryColor,
              fontSize: 22,
            ),
          ),
        ),
        SalatItem(
          iconPath: 'assets/images/sunrise.png',
          isTime: false,
          nameSalat: 'Fajer',
          time: '06:14',
        ),
        SalatItem(
          iconPath: 'assets/images/sunny.png',
          isTime: true,
          nameSalat: 'Duher',
          time: '12:09',
        ),
        SalatItem(
          iconPath: 'assets/images/sunny_with_cloud.png',
          isTime: false,
          nameSalat: 'Aser',
          time: '04:26',
        ),
        SalatItem(
          iconPath: 'assets/images/sunset.png',
          isTime: false,
          nameSalat: 'Maghrib',
          time: '06:30',
        ),
        SalatItem(
          iconPath: 'assets/images/clearn_night.png',
          isTime: false,
          nameSalat: 'Eisha',
          time: '07:30',
        ),
      ],
    );
  }
}

class SalatItem extends StatelessWidget {
  final bool isTime;
  final String nameSalat;
  final String time;
  final String iconPath;
  const SalatItem({
    super.key,
    required this.isTime,
    required this.nameSalat,
    required this.time,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: isTime ? Color(0xffdd96fa).withAlpha(400) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isTime ? primaryColor : Colors.grey.shade300,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  iconPath,
                  height: 36,
                  width: 36,
                ),
              ),
              Gap(10),
              Text(
                nameSalat,
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: theredColor,
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  time,
                  style: TextStyle(
                    fontFamily: poppins,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeLocationItem extends StatelessWidget {
  const ChangeLocationItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        border: Border.all(color: primaryColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: primaryColor,
                  ),
                  child: Icon(
                    Icons.fmd_good_sharp,
                    color: Colors.white,
                  ),
                ),
                Gap(20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Location',
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    Text(
                      'Algeria ,Ain Defla ,Boumedfea',
                      style: TextStyle(
                        fontFamily: poppins,
                        fontWeight: FontWeight.bold,
                        color: theredColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Image.asset('assets/images/vector.png'),
                      Gap(16),
                      Text(
                        'Update your Location',
                        style: TextStyle(
                          fontFamily: poppins,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffa2a1ff),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
