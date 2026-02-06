abstract class ConnectionRepo {
  Future<bool> getConnectionStatus();
  Stream<bool> listenToConnectionStatus();
}
