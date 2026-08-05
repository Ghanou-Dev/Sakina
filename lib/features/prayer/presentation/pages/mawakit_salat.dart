import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/constants/fonts.dart';
import 'package:sakina/core/helpers/extansions.dart';
import 'package:sakina/features/prayer/presentation/cubits/location_cubit/location_cubit.dart';
import 'package:sakina/features/prayer/presentation/cubits/prayer_cubit/prayer_cubit.dart';
import 'package:sakina/features/prayer/presentation/widgets/change_location_item.dart';
import 'package:sakina/features/prayer/presentation/widgets/current_salat_item.dart';
import 'package:sakina/features/prayer/presentation/widgets/todays_prayer_time_list.dart';

class MawakitSalat extends StatefulWidget {
  const MawakitSalat({super.key});

  @override
  State<MawakitSalat> createState() => _MawakitSalatState();
}

class _MawakitSalatState extends State<MawakitSalat> {
  @override
  void initState() {
    super.initState();

    final locationState = context.read<LocationCubit>().state;

    if (locationState is LocationInitial) {
      context.read<PrayerCubit>().getPrayerTimes(
        locationEntity: locationState.locationEntity,
      );
    }
  }

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is LocationLoading) {
          isLoading = true;
        } else {
          isLoading = false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              scrolledUnderElevation: 0,
              title: Text(
                'Mawaqit Al-Salat'.tr(context),
                style: TextStyle(
                  fontFamily: poppins,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                children: <Widget>[
                  CurrentSalatItem(),
                  Expanded(
                    child: ListView(
                      children: [
                        // Gap(10),
                        TodaysPriyerTimeList(),
                      ],
                    ),
                  ),
                  Gap(10),
                  ChangeLocationItem(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
