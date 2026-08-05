import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/prayer/presentation/cubits/prayer_cubit/prayer_cubit.dart';
import 'package:timezone/timezone.dart';

class CurrentSalatItem extends StatefulWidget {
  const CurrentSalatItem({super.key});

  @override
  State<CurrentSalatItem> createState() => _CurrentSalatItemState();
}

class _CurrentSalatItemState extends State<CurrentSalatItem> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<PrayerCubit, PrayerState>(
      listenWhen: (previous, current) {
        return previous.prayerTimesEntity != current.prayerTimesEntity;
      },
      listener: (context, state) {
        final prayerTimesEntity = state.prayerTimesEntity;

        if (prayerTimesEntity != null) {
          final Prayer nextPrayer = prayerTimesEntity.prayerTimes.nextPrayer(
            date: DateTime.now(),
          );

          final DateTime nextPrayerTime = prayerTimesEntity.prayerTimes
              .timeForPrayer(
                nextPrayer,
              );

          final localNextPrayerTime = TZDateTime.from(
            nextPrayerTime,
            local,
          );

          final diffrence = localNextPrayerTime.difference(DateTime.now());

          context.read<PrayerCubit>().getReminig(
            duration: diffrence,
          );
        }
      },

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
        // get name of next prayer
        String currentSalatName = '';
        if (localNextPrayerTime == state.prayerTimesEntity!.fajer) {
          currentSalatName = 'Fajer';
        } else if (localNextPrayerTime == state.prayerTimesEntity!.sunrise) {
          currentSalatName = 'Dhuhr';
        } else if (localNextPrayerTime == state.prayerTimesEntity!.duher) {
          currentSalatName = 'Dhuhr';
        } else if (localNextPrayerTime == state.prayerTimesEntity!.asr) {
          currentSalatName = 'Asr';
        } else if (localNextPrayerTime == state.prayerTimesEntity!.maghrib) {
          currentSalatName = 'Maghrib';
        } else {
          currentSalatName = 'Iisha';
        }
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
                          AppColors.primaryColor,
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
                            fontFamily: poppins,
                            fontWeight: FontWeight.normal,
                            color: AppColors.deepBlue,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          currentSalatName,
                          style: TextStyle(
                            fontFamily: poppins,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBlue,
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
                          fontFamily: poppins,
                          color: AppColors.orange,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        '${localNextPrayerTime.hour.toString().padLeft(2, '0')}:${localNextPrayerTime.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          fontFamily: poppins,
                          color: AppColors.deepBlue,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(color: Colors.grey.shade300),
                      ),
                      BlocBuilder<PrayerCubit, PrayerState>(
                        builder: (context, state) {
                          return Text(
                            state.remining,
                            style: TextStyle(
                              fontFamily: poppins,
                              color: AppColors.primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
