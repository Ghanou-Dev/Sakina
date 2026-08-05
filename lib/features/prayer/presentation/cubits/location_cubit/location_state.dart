part of 'location_cubit.dart';

abstract class LocationState {}

class LocationInitial extends LocationState {
  final LocationEntity locationEntity;
  LocationInitial({required this.locationEntity});
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final LocationEntity locationEntity;
  LocationLoaded({required this.locationEntity});
}

class LocationFailure extends LocationState {
  final String message;
  LocationFailure({required this.message});
}
