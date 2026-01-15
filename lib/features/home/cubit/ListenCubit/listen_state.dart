import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/home/models/reciter_model.dart';

abstract class ListenState {}

class ListenInitial extends ListenState {}

class ListenLoading extends ListenState {}

class ListenFailure extends ListenState {
  final Failure failure;
  ListenFailure({required this.failure});
}

class ListenLoaded extends ListenState {
  final List<ReciterModel> reciters;
  ListenLoaded({required this.reciters});
}
