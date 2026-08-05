class InternetTimeoutEception implements Exception {
  final String? message;
  InternetTimeoutEception({required this.message});
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException({required this.message});
}

class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class CancelException implements Exception {
  final String message;
  CancelException({required this.message});
}

class UnknownException implements Exception {
  final String message;
  UnknownException({required this.message});
}

class CanNotSavedException implements Exception {
  final String message;
  CanNotSavedException({required this.message});
}

class NoSavedException implements Exception {
  final String message;
  NoSavedException({required this.message});
}

class DeleteException implements Exception {
  final String message;
  DeleteException({required this.message});
}

class GetLocationException implements Exception {
  final String message;
  GetLocationException({required this.message});
}

class LocationNotEnabelException implements Exception {
  final String message;
  LocationNotEnabelException({required this.message});
}
