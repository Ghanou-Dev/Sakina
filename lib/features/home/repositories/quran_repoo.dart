import 'package:dartz/dartz.dart';
import 'package:sakina/core/dto/audio_dto.dart';
import 'package:sakina/core/dto/surah_info_dto.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/core/services/quran_services/qurane_service.dart';
import 'package:sakina/features/home/models/audio_model.dart';
import 'package:sakina/features/home/models/ayah_model.dart';
import 'package:sakina/features/home/models/surah_model.dart';
import 'package:sakina/features/home/models/surah_info_model.dart';

class QuranRepoo {
  final QuraneService quraneService;
  QuranRepoo({required this.quraneService});

  Future<Either<Failure, SurahModel>> getSpecialSurah({
    required int surahNumber,
  }) async {
    try {
      final data = await quraneService.fetchSpecialSurah(
        surahNumber: surahNumber,
      );
      SurahModel surah = SurahModel(
        surahName: data.surahName,
        surahNameArabic: data.surahNameArabic,
        surahNameArabicLong: data.surahNameArabicLong,
        surahNameTranslation: data.surahNameTranslation,
        revelationPlace: data.revelationPlace,
        totalAyah: data.totalAyah,
        surahNo: data.surahNo,
        audio: AudioModel(
          affasi: AyahModel(
            reciter: data.audio.one.reciter,
            url: data.audio.one.url,
            originalUrl: data.audio.one.originalUrl,
          ),
          shatri: AyahModel(
            reciter: data.audio.tow.reciter,
            url: data.audio.tow.url,
            originalUrl: data.audio.tow.originalUrl,
          ),
          qatami: AyahModel(
            reciter: data.audio.three.reciter,
            url: data.audio.three.url,
            originalUrl: data.audio.three.originalUrl,
          ),
          adDosari: AyahModel(
            reciter: data.audio.fore.reciter,
            url: data.audio.fore.url,
            originalUrl: data.audio.fore.originalUrl,
          ),
          arRifai: AyahModel(
            reciter: data.audio.five.reciter,
            url: data.audio.five.url,
            originalUrl: data.audio.five.originalUrl,
          ),
        ),
        english: data.english,
        arabic1: data.arabic1,
        arabic2: data.arabic2,
        bengali: data.bengali,
        urdu: data.urdu,
      );
      return Right(surah);
    } on InternetTimeoutEception catch (e) {
      return Left(TimeoutFailure(message: e.message ?? 'Timeoute failure'));
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

  Future<Either<Failure, List<SurahInfoModel>>> getSuwarsInfo() async {
    try {
      List<SurahInfoDto> response = await quraneService.fetchAllSuwarsInfo();
      List<SurahInfoModel> suwars = response
          .map(
            (dto) => SurahInfoModel(
              surahName: dto.surahName,
              surahNameArabic: dto.surahNameArabic,
              surahNameArabicLong: dto.surahNameArabicLong,
              surahNameTranslation: dto.surahNameTranslation,
              revelationPlace: dto.revelationPlace,
              totalAyah: dto.totalAyah,
            ),
          )
          .toList();

      return Right(suwars);
    } on InternetTimeoutEception catch (e) {
      return Left(TimeoutFailure(message: e.message ?? 'Timeout Failure'));
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
        affasi: AyahModel(
          reciter: audio.one.reciter,
          url: audio.one.url,
          originalUrl: audio.one.originalUrl,
        ),
        shatri: AyahModel(
          reciter: audio.tow.reciter,
          url: audio.tow.url,
          originalUrl: audio.tow.originalUrl,
        ),
        qatami: AyahModel(
          reciter: audio.three.reciter,
          url: audio.three.url,
          originalUrl: audio.three.originalUrl,
        ),
        adDosari: AyahModel(
          reciter: audio.fore.reciter,
          url: audio.fore.url,
          originalUrl: audio.fore.originalUrl,
        ),
        arRifai: AyahModel(
          reciter: audio.five.reciter,
          url: audio.five.url,
          originalUrl: audio.five.originalUrl,
        ),
      );
      return Right(ayahAudio);
    } on InternetTimeoutEception catch (e) {
      return Left(TimeoutFailure(message: e.message ?? 'Timeoute failure'));
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
