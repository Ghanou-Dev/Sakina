import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/prayer/domain/entities/location_entity.dart';
import 'package:sakina/features/prayer/domain/entities/prayer_times_entity.dart';

abstract interface class PrayerRepo {
  Future<Either<Failure, LocationEntity>> getLocation();
  Future<Either<Failure, PrayerTimesEntity>> getPrayerTimes({
    required LocationEntity locationEntity,
  });
}
