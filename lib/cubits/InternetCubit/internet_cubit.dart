import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit() : super(InternetInitial());

  late StreamSubscription<InternetStatus> connectionState;
  late bool isConnected;

  Future<bool> simpleCheckConnection() async {
    return await InternetConnection().hasInternetAccess;
  }

  void checkConnection() {
    connectionState = InternetConnection().onStatusChange.listen((stuts) {
      if (stuts == InternetStatus.connected) {
        print('Device is connected');
        isConnected = true;
        emit(InternetConnectionState(isConnected: true));
      } else {
        print('Device is not connected');
        isConnected = false;
        emit(InternetConnectionState(isConnected: false));
      }
    });
  }
}
