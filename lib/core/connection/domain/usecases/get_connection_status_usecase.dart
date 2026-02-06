import 'package:sakina/core/connection/domain/repositories/connection_repo.dart';

class GetConnectionStatusUsecase {
  final ConnectionRepo connectionRepo;
  GetConnectionStatusUsecase({required this.connectionRepo});

  Future<bool> call() async {
    return await connectionRepo.getConnectionStatus();
  }
}
