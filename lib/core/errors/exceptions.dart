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
