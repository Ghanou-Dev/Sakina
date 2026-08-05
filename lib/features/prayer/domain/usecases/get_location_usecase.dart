import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/prayer/domain/entities/location_entity.dart';
import 'package:sakina/features/prayer/domain/repositories/prayer_repo.dart';

class GetLocationUsecase {
  final PrayerRepo prayerRepo;
  GetLocationUsecase({required this.prayerRepo});

  Future<Either<Failure, LocationEntity>> call() {
    return prayerRepo.getLocation();
  }
}
