import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/prayer/domain/entities/location_entity.dart';
import 'package:sakina/features/prayer/domain/entities/prayer_times_entity.dart';
import 'package:sakina/features/prayer/domain/repositories/prayer_repo.dart';

class GetPrayerTimesUsecase {
  final PrayerRepo prayerRepo;
  GetPrayerTimesUsecase({required this.prayerRepo});

  Future<Either<Failure, PrayerTimesEntity>> call({
    required LocationEntity locationEnity,
  }) {
    return prayerRepo.getPrayerTimes(locationEntity: locationEnity);
  }
}
