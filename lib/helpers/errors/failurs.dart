abstract class Failure {}

class TimeoutFailure extends Failure {
  final String? message;
  TimeoutFailure({required this.message});
}

class NoInternetFailure extends Failure {
  final String message;
  NoInternetFailure({required this.message});
}
