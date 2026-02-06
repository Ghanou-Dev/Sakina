part of 'network_cubit.dart';

abstract class NetWorkState {}

class NetWorkInitial extends NetWorkState {}

class NetWorkChanges extends NetWorkState {
  final bool isConnected;
  NetWorkChanges({required this.isConnected});
}
