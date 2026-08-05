import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/prayer/data/models/location_model.dart';
import 'package:sakina/features/prayer/data/models/prayer_times_model.dart';
import 'package:sakina/features/prayer/data/srcs/location_data_src.dart';
import 'package:sakina/features/prayer/data/srcs/prayer_times_data_src.dart';
import 'package:sakina/features/prayer/domain/entities/location_entity.dart';
import 'package:sakina/features/prayer/domain/entities/prayer_times_entity.dart';
import 'package:sakina/features/prayer/domain/repositories/prayer_repo.dart';

class PrayerRepoImpl implements PrayerRepo {
  final LocationDataSrc locationDataSrc;
  final PrayerTimesDataSrc prayerTimesDataSrc;
  PrayerRepoImpl({
    required this.locationDataSrc,
    required this.prayerTimesDataSrc,
  });

  @override
  Future<Either<Failure, LocationEntity>> getLocation() async {
    try {
      LocationModel locationModel = await locationDataSrc.getLocation();
      return Right(locationModel.toEntity());
    } on GetLocationException catch (ex) {
      return Future.value(Left(GetLocationFailure(message: ex.message)));
    } on LocationNotEnabelException catch (ex) {
      return Future.value(Left(LocationNotEnableFailure(message: ex.message)));
    } on Exception catch (ex) {
      return Future.value(Left(UnknownFailure(message: ex.toString())));
    }
  }

  @override
  Future<Either<Failure, PrayerTimesEntity>> getPrayerTimes({
    required LocationEntity locationEntity,
  }) async {
    try {
      PrayerTimesModel prayerTimesModel = await prayerTimesDataSrc
          .getPrayerTimes(
            locationModel: LocationModel.fromEntity(locationEntity),
          );
      return Right(prayerTimesModel.toEntity());
    } on Exception catch (ex) {
      return Left(
        UnknownFailure(message: 'Error Get PrayerTimes: ${ex.toString()} '),
      );
    }
  }
}
