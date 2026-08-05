part of 'prayer_cubit.dart';

class PrayerState {
  final PrayerTimesEntity? prayerTimesEntity;
  final String? failure;
  final String remining;
  PrayerState({this.prayerTimesEntity, this.failure, required this.remining});

  PrayerState copyWith({
    PrayerTimesEntity? prayerTimesEntity,
    String? failure,
    String? remining,
  }) {
    return PrayerState(
      prayerTimesEntity: prayerTimesEntity ?? this.prayerTimesEntity,
      failure: failure ?? this.failure,
      remining: remining ?? this.remining,
    );
  }
}
