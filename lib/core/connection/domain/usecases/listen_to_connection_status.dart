import 'package:sakina/core/connection/domain/repositories/connection_repo.dart';

class ListenToConnectionStatus {
  final ConnectionRepo connectionRepo;
  ListenToConnectionStatus({required this.connectionRepo});

  Stream<bool> call() {
    return connectionRepo.listenToConnectionStatus();
  }
}
