import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:sakina/features/prayer/data/models/location_model.dart';
import 'package:sakina/features/prayer/data/models/prayer_times_model.dart';
import 'package:timezone/timezone.dart' as tz;

abstract interface class PrayerTimesDataSrc {
  Future<PrayerTimesModel> getPrayerTimes({
    required LocationModel locationModel,
  });
}

class PrayerTimesDataSrcImpl implements PrayerTimesDataSrc {
  @override
  Future<PrayerTimesModel> getPrayerTimes({
    required LocationModel locationModel,
  }) async {
    Coordinates coordinates = Coordinates(
      locationModel.latitude,
      locationModel.longitude,
    );
    final params = CalculationMethodParameters.algerian();
    params.madhab = Madhab.shafi;
    PrayerTimes prayerTimes = PrayerTimes(
      date: DateTime.now(),
      coordinates: coordinates,
      calculationParameters: params,
    );
    //
    final TimezoneInfo currentTimeZone =
        await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));
    tz.Location local = tz.local;

    final DateTime fajer = tz.TZDateTime.from(prayerTimes.fajr, local);
    final DateTime sunrise = tz.TZDateTime.from(prayerTimes.sunrise, local);
    final DateTime duher = tz.TZDateTime.from(prayerTimes.dhuhr, local);
    final DateTime asr = tz.TZDateTime.from(prayerTimes.asr, local);
    final DateTime maghrib = tz.TZDateTime.from(prayerTimes.maghrib, local);
    final DateTime iisha = tz.TZDateTime.from(prayerTimes.isha, local);

    return PrayerTimesModel(
      prayerTimes: prayerTimes,
      fajer: fajer,
      sunrise: sunrise,
      duher: duher,
      asr: asr,
      maghrib: maghrib,
      iisha: iisha,
    );
  }
}
