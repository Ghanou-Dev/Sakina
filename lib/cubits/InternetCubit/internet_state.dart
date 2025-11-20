part of 'internet_cubit.dart';

abstract class InternetState {}

class InternetInitial extends InternetState {}

class InternetConnectionState extends InternetState {
  final bool isConnected;
  InternetConnectionState({required this.isConnected});
}
