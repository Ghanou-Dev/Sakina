import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/prayer/presentation/cubits/prayer_cubit/prayer_cubit.dart';
import 'package:sakina/features/prayer/presentation/widgets/salat_item.dart';
import 'package:timezone/timezone.dart';

class TodaysPriyerTimeList extends StatelessWidget {
  const TodaysPriyerTimeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerCubit, PrayerState>(
      builder: (context, state) {
        // get next prayer
        final Prayer nextPrayer = state.prayerTimesEntity!.prayerTimes
            .nextPrayer(
              date: DateTime.now(),
            );
        // get time of next prayer
        final DateTime timeNextPrayer = state.prayerTimesEntity!.prayerTimes
            .timeForPrayer(
              nextPrayer,
            );
        // format local next prayer
        final DateTime localNextPrayerTime = TZDateTime.from(
          timeNextPrayer,
          local,
        );

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Today\'s Payer Times',
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                  fontSize: 22,
                ),
              ),
            ),
            SalatItem(
              iconPath: 'assets/images/sunrise.png',
              isTime: localNextPrayerTime == state.prayerTimesEntity!.fajer,
              nameSalat: 'Fajer',
              time:
                  '${state.prayerTimesEntity!.fajer.hour.toString().padLeft(2, '0')}:${state.prayerTimesEntity!.fajer.minute.toString().padLeft(2, '0')}',
            ),
            SalatItem(
              iconPath: 'assets/images/sunny.png',
              isTime: localNextPrayerTime == state.prayerTimesEntity!.duher,
              nameSalat: 'Dhuhr',
              time:
                  '${state.prayerTimesEntity!.duher.hour.toString().padLeft(2, '0')}:${state.prayerTimesEntity!.duher.minute.toString().padLeft(2, '0')}',
            ),
            SalatItem(
              iconPath: 'assets/images/sunny_with_cloud.png',
              isTime: localNextPrayerTime == state.prayerTimesEntity!.asr,
              nameSalat: 'Asr',
              time:
                  '${state.prayerTimesEntity!.asr.hour.toString().padLeft(2, '0')}:${state.prayerTimesEntity!.fajer.minute.toString().padLeft(2, '0')}',
            ),
            SalatItem(
              iconPath: 'assets/images/sunset.png',
              isTime: localNextPrayerTime == state.prayerTimesEntity!.maghrib,
              nameSalat: 'Maghrib',
              time:
                  '${state.prayerTimesEntity!.maghrib.hour.toString().padLeft(2, '0')}:${state.prayerTimesEntity!.maghrib.minute.toString().padLeft(2, '0')}',
            ),
            SalatItem(
              iconPath: 'assets/images/clearn_night.png',
              isTime: localNextPrayerTime == state.prayerTimesEntity!.ishaa,
              nameSalat: 'Iisha',
              time:
                  '${state.prayerTimesEntity!.ishaa.hour.toString().padLeft(2, '0')}:${state.prayerTimesEntity!.ishaa.minute.toString().padLeft(2, '0')}',
            ),
          ],
        );
      },
    );
  }
}
