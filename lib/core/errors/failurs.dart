abstract class Failure {
  final String message;
  Failure({required this.message});
}

class TimeoutFailure extends Failure {
  TimeoutFailure({required super.message});
}

class NoInternetFailure extends Failure {
  NoInternetFailure({required super.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message});
}

class CancelFailure extends Failure {
  CancelFailure({required super.message});
}

class UnknownFailure extends Failure {
  UnknownFailure({required super.message});
}

class CanNotSavedFailure extends Failure {
  CanNotSavedFailure({required super.message});
}

class NoSavedFailure extends Failure {
  NoSavedFailure({required super.message});
}

class DeleteFailure extends Failure {
  DeleteFailure({required super.message});
}

class GetLocationFailure extends Failure {
  GetLocationFailure({required super.message});
}

class LocationNotEnableFailure extends Failure {
  LocationNotEnableFailure({required super.message});
}
