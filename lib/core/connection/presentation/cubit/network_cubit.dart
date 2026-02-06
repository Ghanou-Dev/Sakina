import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/connection/domain/usecases/get_connection_status_usecase.dart';
import 'package:sakina/core/connection/domain/usecases/listen_to_connection_status.dart';

part 'network_state.dart';

class NetWorkCubit extends Cubit<NetWorkState> {
  final GetConnectionStatusUsecase getConnectionStatusUsecase;
  final ListenToConnectionStatus listenToConnectionStatus;
  NetWorkCubit({
    required this.getConnectionStatusUsecase,
    required this.listenToConnectionStatus,
  }) : super(NetWorkInitial());
  late StreamSubscription subscription;

  Future<void> getStatus() async {
    final bool status = await getConnectionStatusUsecase.call();
    emit(NetWorkChanges(isConnected: status));
  }

  void listenToStatusChanges() {
    subscription = listenToConnectionStatus.call().listen(
      (status) {
        emit(NetWorkChanges(isConnected: status));
      },
    );
  }

  @override
  Future<void> close() {
    subscription.cancel();
    return super.close();
  }
}
