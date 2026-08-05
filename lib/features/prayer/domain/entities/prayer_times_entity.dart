import 'package:adhan_dart/adhan_dart.dart';

class PrayerTimesEntity {
  final PrayerTimes prayerTimes;
  final DateTime fajer;
  final DateTime sunrise;
  final DateTime duher;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime ishaa;
  PrayerTimesEntity({
    required this.prayerTimes,
    required this.fajer,
    required this.sunrise,
    required this.duher,
    required this.asr,
    required this.maghrib,
    required this.ishaa,
  });
}
