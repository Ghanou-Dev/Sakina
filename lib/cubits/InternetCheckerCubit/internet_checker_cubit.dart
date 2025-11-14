import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sakina/cubits/InternetCheckerCubit/internet_checker_state.dart';

class InternetCheckerCubit extends Cubit<InternetCheckerState> {
  InternetCheckerCubit() : super(InternetCheckerInitial());

  late StreamSubscription<InternetConnectionStatus> connectionStreamChecker;

  InternetConnectionStatus? connectionState;

  void checkConnection() async {
    connectionStreamChecker = InternetConnectionChecker.createInstance()
        .onStatusChange
        .listen((state) {
          switch (state) {
            case InternetConnectionStatus.connected:
              connectionState = InternetConnectionStatus.connected;
              emit(InternetCheckerCheck(isConnection: true));
              break;

            case InternetConnectionStatus.disconnected:
              connectionState = InternetConnectionStatus.disconnected;
              emit(InternetCheckerCheck(isConnection: false));
              break;

            case InternetConnectionStatus.slow:
              connectionState = InternetConnectionStatus.slow;
              emit(InternetCheckerCheck(isConnection: true, isLow: true));
          }
        });
  }

  @override
  Future<void> close() {
    connectionStreamChecker.cancel();
    return super.close();
  }
}
