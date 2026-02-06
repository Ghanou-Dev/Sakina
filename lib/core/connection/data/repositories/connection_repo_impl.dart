import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sakina/core/connection/domain/repositories/connection_repo.dart';

class ConnectionRepoImpl implements ConnectionRepo {
  final InternetConnection connection;
  ConnectionRepoImpl({required this.connection});
  @override
  Future<bool> getConnectionStatus() async {
    return await connection.hasInternetAccess;
  }

  @override
  Stream<bool> listenToConnectionStatus() {
    return connection.onStatusChange.map(
      (status) {
        return status == InternetStatus.connected;
      },
    );
  }
}
