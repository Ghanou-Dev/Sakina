abstract class Failure {}

class TimeoutFailure extends Failure {
  final String? message;
  TimeoutFailure({required this.message});
}

class NoInternetFailure extends Failure {
  final String message;
  NoInternetFailure({required this.message});
}

class ServerFailure extends Failure {
  final String message;
  ServerFailure({required this.message});
}

class CancelFailure extends Failure {
  final String message;
  CancelFailure({required this.message});
}

class UnknownFailure extends Failure {
  final String message;
  UnknownFailure({required this.message});
}
