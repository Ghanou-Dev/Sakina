import 'package:just_audio_background/just_audio_background.dart';

abstract class AudioState {}

class AudioInitial extends AudioState {}

class AudioLoading extends AudioState {}

class AudioLoaded extends AudioState {
  final int index;
  final bool isPlaying;
  final int? currentAyah;
  final MediaItem? mediaItem; // ✨ جديد
  AudioLoaded({
    required this.index,
    required this.isPlaying,
    this.currentAyah,
    this.mediaItem,
  });
}

class AudioLastRead extends AudioState {
  final String lastRead;
  final int ayahNumber;
  AudioLastRead({required this.ayahNumber, required this.lastRead});
}
