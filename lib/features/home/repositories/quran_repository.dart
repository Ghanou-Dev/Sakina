import 'package:dartz/dartz.dart';
import 'package:sakina/core/dto/surah_dto.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/core/services/qurane_service.dart';
import 'package:sakina/features/home/models/audio_model.dart';
import 'package:sakina/features/home/models/aya_model.dart';
import 'package:sakina/features/home/models/sura_model.dart';

class QuranRepository {
  final QuraneService quraneService;
  QuranRepository({required this.quraneService});

  Future<Either<Failure, List<SuraModel>>> getSuwars() async {
    try {
      List<SurahDto> response = await quraneService.fetchAllSuwars();
      List<SuraModel> suwars = response
          .map(
            (dto) => SuraModel(
              surahName: dto.surahName,
              surahNameArabic: dto.surahNameArabic,
              surahNameArabicLong: dto.surahNameArabicLong,
              surahNameTranslation: dto.surahNameTranslation,
              revelationPlace: dto.revelationPlace,
              totalAyah: dto.totalAyah,
              surahNo: dto.surahNo,
              audio: AudioModel(
                affasi: AyaModel(
                  reciter: dto.audio.five.reciter,
                  url: dto.audio.five.url,
                  originalUrl: dto.audio.five.originalUrl,
                ),
                shatri: AyaModel(
                  reciter: dto.audio.tow.reciter,
                  url: dto.audio.tow.url,
                  originalUrl: dto.audio.tow.originalUrl,
                ),
                qatami: AyaModel(
                  reciter: dto.audio.three.reciter,
                  url: dto.audio.three.url,
                  originalUrl: dto.audio.three.originalUrl,
                ),
                adDosari: AyaModel(
                  reciter: dto.audio.fore.reciter,
                  url: dto.audio.fore.url,
                  originalUrl: dto.audio.fore.originalUrl,
                ),
                arRifai: AyaModel(
                  reciter: dto.audio.one.reciter,
                  url: dto.audio.one.url,
                  originalUrl: dto.audio.one.originalUrl,
                ),
              ),
              english: dto.english,
              arabic1: dto.arabic1,
              arabic2: dto.arabic2,
              bengali: dto.bengali,
              urdu: dto.urdu,
            ),
          )
          .toList();

      return Right(suwars);
    } on InternetTimeoutEception catch (e) {
      return Left(TimeoutFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoInternetException catch (e) {
      return Left(NoInternetFailure(message: e.message));
    } on CancelException catch (e) {
      return Left(CancelFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }

  Future<Either<Failure, AudioModel>> getSpecialAyahAudio({
    required int surahNo,
    required int ayahNo,
  }) async {
    try {
      AudioDto audio = await quraneService.fetchAyahAudio(
        surahNo: surahNo,
        ayahNo: ayahNo,
      );
      AudioModel ayahAudio = AudioModel(
        affasi: AyaModel(
          reciter: audio.one.reciter,
          url: audio.one.url,
          originalUrl: audio.one.originalUrl,
        ),
        shatri: AyaModel(
          reciter: audio.tow.reciter,
          url: audio.tow.url,
          originalUrl: audio.tow.originalUrl,
        ),
        qatami: AyaModel(
          reciter: audio.three.reciter,
          url: audio.three.url,
          originalUrl: audio.three.originalUrl,
        ),
        adDosari: AyaModel(
          reciter: audio.fore.reciter,
          url: audio.fore.url,
          originalUrl: audio.fore.originalUrl,
        ),
        arRifai: AyaModel(
          reciter: audio.five.reciter,
          url: audio.five.url,
          originalUrl: audio.five.originalUrl,
        ),
      );
      return Right(ayahAudio);
    } on InternetTimeoutEception catch (e) {
      return Left(TimeoutFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoInternetException catch (e) {
      return Left(NoInternetFailure(message: e.message));
    } on CancelException catch (e) {
      return Left(CancelFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }
}
