import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/features/prayer/presentation/cubits/location_cubit/location_cubit.dart';
import 'package:sakina/features/prayer/presentation/cubits/prayer_cubit/prayer_cubit.dart';

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
        border: Border.all(color: AppColors.primaryColor),
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
                    color: AppColors.primaryColor,
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
                        color: AppColors.primaryColor,
                      ),
                    ),
                    BlocBuilder<LocationCubit, LocationState>(
                      builder: (context, state) {
                        if (state is LocationInitial) {
                          return Text(
                            state.locationEntity.addressName,
                            style: TextStyle(
                              fontFamily: poppins,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepBlue,
                            ),
                          );
                        } else if (state is LocationFailure) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                state.message,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: poppins,
                                ),
                              ),
                            ),
                          );
                          return Text(
                            '--- , --- , ---',
                            style: TextStyle(
                              fontFamily: poppins,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepBlue,
                            ),
                          );
                        } else if (state is LocationLoaded) {
                          // get prayer times //////////////////////////////////
                          context.read<PrayerCubit>().getPrayerTimes(
                            locationEntity: state.locationEntity,
                          );
                          return Text(
                            state.locationEntity.addressName,
                            style: TextStyle(
                              fontFamily: poppins,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepBlue,
                            ),
                          );
                        } else {
                          return Text(
                            '--- , --- , ---',
                            style: TextStyle(
                              fontFamily: poppins,
                              fontWeight: FontWeight.bold,
                              color: AppColors.deepBlue,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () async {
                    await context.read<LocationCubit>().getLocation();
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/images/vector.png'),
                      Gap(16),
                      Text(
                        'Update Your Location',
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
