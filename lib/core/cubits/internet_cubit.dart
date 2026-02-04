import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetState(isConnected: true));

  Future<void> checkConnection() async {
    final bool isConnected = await InternetConnection().hasInternetAccess;
    emit(InternetState(isConnected: isConnected));
  }

  // listen to change connection
  late StreamSubscription<InternetStatus> connectionChanges;
  void listenToConnectionChanges() async {
    connectionChanges = InternetConnection().onStatusChange.listen((status) {
      emit(InternetState(isConnected: status == InternetStatus.connected));
    });
  }

  @override
  Future<void> close() {
    connectionChanges.cancel();
    return super.close();
  }
}
