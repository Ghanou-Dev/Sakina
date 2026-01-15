class AudioState {
  final bool isLoading;
  final bool isPlaying;
  final int index;

  final Duration position;
  final Duration buffered;
  final Duration total;
  AudioState({
    required this.isLoading,
    required this.isPlaying,
    required this.index,

    required this.position,
    required this.buffered,
    required this.total,
  });

  AudioState copyWith({
    bool? isLoading,
    bool? isPlaying,
    int? index,

    Duration? position,
    Duration? buffered,
    Duration? total,
  }) {
    return AudioState(
      isLoading: isLoading ?? this.isLoading,
      isPlaying: isPlaying ?? this.isPlaying,
      index: index ?? this.index,
      position: position ?? this.position,
      buffered: buffered ?? this.buffered,
      total: total ?? this.buffered,
    );
  }
}
