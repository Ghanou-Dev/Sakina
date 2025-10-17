import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/models/ayah_model.dart';
import 'package:sakina/cubits/AudioCubit/audio_state.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sakina/models/reciter_chikh_model.dart';
import 'package:sakina/models/reciter_model.dart';
import 'package:sakina/widgets/custom_item_surah.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioPlayer _player = AudioPlayer();
  AudioCubit() : super(AudioInitial()) {
    init();
  }

  int currentAyah = 0;
  String lastSurahRead = 'Al-Fatiha';

  int index = 0;
  bool lastPlayingState = false;

  Future<void> init() async {
    // استمع لحالة التشغيل لتحديث واجهة المستخدم
    _player.playerStateStream.listen((state) {
      final bool isPlaying = state.playing;
      final processing = state.processingState;
      if (lastPlayingState != isPlaying) {
        lastPlayingState = isPlaying;
        if (processing == ProcessingState.completed) {
          emit(
            AudioLoaded(
              isPlaying: false,
              currentAyah: currentAyah,
              index: index,
            ),
          );
        } else {
          emit(
            AudioLoaded(
              isPlaying: isPlaying,
              currentAyah: currentAyah,
              index: index,
            ),
          );
        }
      }
    });

    // استمع لتغيير الفهرس وسجل في الـ cubit
    _player.currentIndexStream.listen((newIndex) {
      if (newIndex != null) {
        index = newIndex;
        emit(
          AudioLoaded(
            index: index,
            isPlaying: _player.playing,
            currentAyah: currentAyah,
          ),
        );
      }
    });
  }

  Future<void> playAyah({
    required AyahModel ayah,
    required CustomItemSurah surah,
  }) async {
    lastSurahRead = surah.englishName;
    currentAyah = ayah.numberInSurah;
    await _player.setAudioSource(
      AudioSource.uri(
        Uri.parse(ayah.audio!),
        tag: MediaItem(
          id: '${ayah.numberInSurah}',
          title: surah.englishName,
          artist: 'Abdurrahmaan As-Sudais',
          artUri: Uri.parse(
            'https://tse3.mm.bing.net/th/id/OIP.8gioDR7LjDgYuzJPGgpc1QHaEJ?cb=12&rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ),
      ),
      initialPosition: Duration.zero,
    );
    await _player.play();
    emit(AudioLastRead(ayahNumber: currentAyah, lastRead: lastSurahRead));
  }

  Future<void> playSurah({
    required int initialIndex,
    required ReciterModel reciter,
    required ReciterChikhModel chikh,
    required List<CustomItemSurah> suwars,
  }) async {
    index = initialIndex;
    List<String> numberSuwars = reciter.surah_list;
    List<String> urls = numberSuwars
        .map(
          (number) => '${reciter.server}${number.padLeft(3, '0')}.mp3',
        )
        .toList();

    List<AudioSource> playList = List.generate(urls.length, (i) {
      return AudioSource.uri(
        Uri.parse(urls[i]),
        tag: MediaItem(
          id: urls[i],
          title: suwars[i].englishName,
          artist: chikh.name,
          artUri: Uri.parse(
            'https://tse3.mm.bing.net/th/id/OIP.8gioDR7LjDgYuzJPGgpc1QHaEJ?cb=12&rs=1&pid=ImgDetMain&o=7&rm=3',
          ),
        ),
      );
    });

    await _player.setAudioSources(playList, initialIndex: index);
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
    emit(AudioLoaded(index: index, isPlaying: false, currentAyah: currentAyah));
  }

  Future<void> resume() async {
    await _player.play();
    emit(AudioLoaded(index: index, isPlaying: true, currentAyah: currentAyah));
  }

  Future<void> stop() async {
    await _player.stop();
  }

  Future<void> next() async {
    await _player.seekToNext();
  }

  Future<void> previous() async {
    await _player.seekToPrevious();
  }

  Future<void> seek({required Duration position}) async {
    await _player.seek(position);
  }

  Duration get duration => _player.duration ?? Duration.zero;
  Stream<Duration> get position => _player.positionStream;

  @override
  Future<void> close() async {
    await _player.dispose();
    super.close();
  }
}
