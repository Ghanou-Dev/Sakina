class InternetTimeoutEception implements Exception {
  final String? message;
  InternetTimeoutEception({required this.message});
}

class NoInternetException implements Exception {
  final String message;
  NoInternetException({required this.message});
}
