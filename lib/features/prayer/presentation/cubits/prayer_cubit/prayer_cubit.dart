import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/prayer/domain/entities/location_entity.dart';
import 'package:sakina/features/prayer/domain/entities/prayer_times_entity.dart';
import 'package:sakina/features/prayer/domain/usecases/get_prayer_times_usecase.dart';

part 'prayer_state.dart';

class PrayerCubit extends Cubit<PrayerState> {
  final GetPrayerTimesUsecase getPrayerTimesUsecase;

  PrayerCubit({required this.getPrayerTimesUsecase})
    : super(
        PrayerState(
          remining: '00:00:00',
          prayerTimesEntity: _generateDefaultPrayerTimes(),
        ),
      );

  static PrayerTimesEntity _generateDefaultPrayerTimes() {
    final coordinates = Coordinates(
      36.7538,
      3.0588,
    );

    final params = CalculationMethodParameters.muslimWorldLeague();

    final prayerTimes = PrayerTimes(
      coordinates: coordinates,
      date: DateTime.now(),
      calculationParameters: params,
    );

    return PrayerTimesEntity(
      prayerTimes: prayerTimes,
      fajer: prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      duher: prayerTimes.dhuhr,
      asr: prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      ishaa: prayerTimes.isha,
    );
  }

  Future<void> getPrayerTimes({required LocationEntity locationEntity}) async {
    Either<Failure, PrayerTimesEntity> result = await getPrayerTimesUsecase(
      locationEnity: locationEntity,
    );
    result.fold(
      (failure) {
        emit(state.copyWith(failure: failure.message));
      },
      (prayerTimesEntity) {
        emit(state.copyWith(prayerTimesEntity: prayerTimesEntity));
      },
    );
  }

  Timer? timer;

  void getReminig({required Duration duration}) {
    int allSeconds = duration.inSeconds;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      allSeconds--;
      int houre = allSeconds ~/ 3600;
      int minute = (allSeconds % 3600) ~/ 60;
      int second = allSeconds % 60;
      emit(
        state.copyWith(
          remining:
              '${houre.toString().padLeft(2, '0')} : ${minute.toString().padLeft(2, '0')} : ${second.toString().padLeft(2, '0')}',
        ),
      );
    });
  }

  @override
  Future<void> close() {
    timer?.cancel();
    return super.close();
  }
}
