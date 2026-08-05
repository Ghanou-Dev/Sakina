import 'package:adhan_dart/adhan_dart.dart';
import 'package:sakina/core/constants/app_keys.dart';
import 'package:sakina/features/prayer/domain/entities/prayer_times_entity.dart';

class PrayerTimesModel {
  final PrayerTimes prayerTimes;
  final DateTime fajer;
  final DateTime sunrise;
  final DateTime duher;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime iisha;

  PrayerTimesModel({
    required this.prayerTimes,
    required this.fajer,
    required this.sunrise,
    required this.duher,
    required this.asr,
    required this.maghrib,
    required this.iisha,
  });

  factory PrayerTimesModel.fromEntity(PrayerTimesEntity prayerTimesEntity) {
    return PrayerTimesModel(
      prayerTimes: prayerTimesEntity.prayerTimes,
      fajer: prayerTimesEntity.fajer,
      sunrise: prayerTimesEntity.sunrise,
      duher: prayerTimesEntity.duher,
      asr: prayerTimesEntity.asr,
      maghrib: prayerTimesEntity.maghrib,
      iisha: prayerTimesEntity.ishaa,
    );
  }

  PrayerTimesEntity toEntity() {
    return PrayerTimesEntity(
      prayerTimes: prayerTimes,
      fajer: fajer,
      sunrise: sunrise,
      duher: duher,
      asr: asr,
      maghrib: maghrib,
      ishaa: iisha,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      AppKeys.prayerTimes: prayerTimes,
      AppKeys.fajer: fajer,
      AppKeys.sunrise: sunrise,
      AppKeys.duher: duher,
      AppKeys.asr: asr,
      AppKeys.maghrib: maghrib,
      AppKeys.iisha: iisha,
    };
  }
}
