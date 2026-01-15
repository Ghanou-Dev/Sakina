import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    debugPrint(
      'BLOC => $bloc \n Current State => ${change.currentState} \n Next State => ${change.nextState} \n\n',
    );
  }
}
