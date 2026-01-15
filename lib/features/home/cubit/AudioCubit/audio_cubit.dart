import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_state.dart';
import 'package:sakina/features/home/models/moshafe_model.dart';
import 'package:sakina/features/home/widgets/tadabbor_tap/item_surah_info.dart';
import 'package:rxdart/rxdart.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayer player = AudioPlayer();
  late StreamSubscription dataPositionStream;
  AudioCubit()
    : super(
        AudioState(
          isLoading: false,
          isPlaying: false,
          index: 0,
          position: Duration.zero,
          buffered: Duration.zero,
          total: Duration.zero,
        ),
      ) {
    init();
    initListenDataStream();

    player.durationStream.listen(
      (totalDuration) {
        total = totalDuration ?? Duration.zero;
      },
    );
  }

  Duration total = Duration.zero;

  void initListenDataStream() {
    dataPositionStream =
        Rx.combineLatest3<Duration, Duration, Duration?, AudioState>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
          (position, buffered, total) => state.copyWith(
            position: position,
            buffered: buffered,
            total: total ?? Duration.zero,
          ),
        ).listen(
          (newState) => emit(newState),
        );
  }

  @override
  Future<void> close() {
    dataPositionStream.cancel();
    return super.close();
  }

  void init() async {
    // الاستماع لتغير حالة التشغيل
    player.playerStateStream.listen((playerState) {
      emit(
        state.copyWith(
          isLoading: false,
          isPlaying: playerState.playing,
          index: state.index,
        ),
      );
    });

    // الاستماع لتغيير فهرس السور
    player.currentIndexStream.listen(
      (index) {
        currentIndex = index ?? 0;
        emit(
          state.copyWith(
            isLoading: false,
            isPlaying: state.isPlaying,
            index: index ?? 0,
          ),
        );
      },
    );
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
    await player.play().then(
      (value) {
        player.stop();
      },
    );
  }

  int currentIndex = 0;
  String moshafeName = '';
  String currentReciter = '';

  Future<void> playSpecialMoshafe({
    required List<ItemSurahInfo> surahInfo,
    required MoshafeModel moshafe,
    required String reciterName,
    required List<String> suwarsUrls,
    required int index,
  }) async {
    currentIndex = index;
    moshafeName = moshafe.name;
    currentReciter = reciterName;
    List<AudioSource> audioSources = List.generate(
      suwarsUrls.length,
      (index) => AudioSource.uri(
        Uri.parse(suwarsUrls[index]),
        tag: MediaItem(
          id: suwarsUrls[index],
          title: surahInfo[int.parse(moshafe.surahList[index]) - 1].surahName,
          artist: reciterName,
          artUri: Uri.parse(
            'https://th.bing.com/th/id/OIP.8gioDR7LjDgYuzJPGgpc1QHaEJ?w=327&h=183&c=7&r=0&o=7&cb=ucfimg2&dpr=1.5&pid=1.7&rm=3&ucfimg=1',
          ),
        ),
      ),
    );
    await player.setAudioSources(audioSources, initialIndex: index);
    await player.play();
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
