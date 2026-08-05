import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/prayer/domain/entities/location_entity.dart';
import 'package:sakina/features/prayer/domain/usecases/get_location_usecase.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  final GetLocationUsecase getLocationUsecase;
  LocationCubit({
    required this.getLocationUsecase,
  }) : super(
         LocationInitial(
           locationEntity: LocationEntity(
             latitude: 36.7538,
             longitude: 3.0588,
             addressName: 'Algeria ,algeria',
           ),
         ),
       );

  Future<void> getLocation() async {
    emit(LocationLoading());
    Either<Failure, LocationEntity> result = await getLocationUsecase();
    result.fold(
      (failure) {
        emit(LocationFailure(message: failure.message));
      },
      (locationEntity) {
        emit(LocationLoaded(locationEntity: locationEntity));
      },
    );
  }
}
