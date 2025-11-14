abstract class InternetCheckerState {}

class InternetCheckerInitial extends InternetCheckerState {}

class InternetCheckerCheck extends InternetCheckerState {
  final bool isConnection;
  final bool isLow;
  InternetCheckerCheck({required this.isConnection, this.isLow = false});
}
