import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayer player = AudioPlayer();
  AudioCubit() : super(AudioInitial()) {
    init();
  }

  void init() async {
    // الاستماع لتغير حالة التشغيل
    player.playerStateStream.listen((state) {
      if (state.playing) {
        emit(AudioPlayingState(url: null));
      } else {
        emit(AudioPausedState());
      }
    });
  }

  void emitInitState() {
    emit(AudioInitial());
  }

  Future<void> playSpecialAyah({
    required String url,
    required String surahName,
    required String artist,
  }) async {
    await player.setAudioSource(
      AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: url,
          title: surahName,
          artist: artist,
          artUri: Uri.parse(
            'https://th.bing.com/th/id/OIP.8gioDR7LjDgYuzJPGgpc1QHaEJ?w=327&h=183&c=7&r=0&o=7&cb=ucfimg2&dpr=1.5&pid=1.7&rm=3&ucfimg=1',
          ),
        ),
      ),
    );
    emit(AudioPlayingState(url: url));
    await player.play().then(
      (value) {
        player.stop();
      },
    );
  }

  Future<void> play() async {
    await player.play();
  }

  Future<void> stop() async {
    await player.stop();
  }

  Future<void> pause() async {
    await player.pause();
  }

  Future<void> next() async {
    await player.seekToNext();
  }

  Future<void> previous() async {
    await player.seekToPrevious();
  }

  Future<void> seek(Duration position) async {
    await player.seek(position);
  }
}
