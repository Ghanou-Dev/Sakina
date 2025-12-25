abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioLoading extends AudioState {}

class AudioPlayingState extends AudioState {
  final String? url;
  AudioPlayingState({required this.url});
}

class AudioPausedState extends AudioState {
  AudioPausedState();
}

class AudioStoppedState extends AudioState {
  AudioStoppedState();
}
