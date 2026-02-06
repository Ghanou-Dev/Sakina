import 'package:equatable/equatable.dart';

class ConnectionstatusEntity extends Equatable {
  final bool isConnected;
  const ConnectionstatusEntity({required this.isConnected});

  @override
  List<Object?> get props => [isConnected];
}
