import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/data/data_sources/saved_data_source.dart';
import 'package:sakina/features/saved/data/models/saved_ayah_model.dart';
import 'package:sakina/features/saved/data/models/saved_hadith_model.dart';
import 'package:sakina/features/saved/data/models/saved_surah_model.dart';
import 'package:sakina/features/saved/domain/entitys/saved_ayah_entity.dart';
import 'package:sakina/features/saved/domain/entitys/saved_hadith_entity.dart';
import 'package:sakina/features/saved/domain/entitys/saved_surah_entity.dart';
import 'package:sakina/features/saved/domain/repositories/saved_repo.dart';

class SavedRepoImpl implements SavedRepo {
  final SavedDataSource savedDataSource;
  SavedRepoImpl({
    required this.savedDataSource,
  });

  @override
  Future<Either<Failure, Unit>> removeHadith({
    required SavedHadithEntity savedHadithEntity,
  }) async {
    try {
      await savedDataSource.removeHadith(
        hadith: SavedHadithModel(
          hadithArabic: savedHadithEntity.hadithArabic,
          hadithEnglish: savedHadithEntity.hadithEnglish,
          status: savedHadithEntity.status,
          chapterArabic: savedHadithEntity.chapterArabic,
          chapterEnglish: savedHadithEntity.chapterEnglish,
          englishNarrator: savedHadithEntity.englishNarrator,
          headingArabic: savedHadithEntity.headingArabic,
          headingEnglish: savedHadithEntity.headingEnglish,
        ),
      );
      return Right(unit);
    } on DeleteException catch (ex) {
      return Left(DeleteFailure(message: ex.message));
    } catch (ex) {
      return Left(UnknownFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeSurah({
    required SavedSurahEntity savedSurahEntity,
  }) async {
    try {
      await savedDataSource.removeSurah(
        surah: SavedSurahModel(
          numberSurah: savedSurahEntity.numberSurah,
          surahArabicName: savedSurahEntity.surahArabicName,
          surahEnglishName: savedSurahEntity.surahEnglishName,
          reciterName: savedSurahEntity.reciterName,
          mushafeName: savedSurahEntity.mushafeName,
          surahUrl: savedSurahEntity.surahUrl,
          type: savedSurahEntity.type,
          numberVerses: savedSurahEntity.numberVerses,
        ),
      );
      return Right(unit);
    } on DeleteException catch (ex) {
      return Left(DeleteFailure(message: ex.message));
    } catch (ex) {
      return Left(UnknownFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeVerse({
    required SavedAyahEntity savedAyahEntity,
  }) async {
    try {
      await savedDataSource.removeVerse(
        ayah: SavedAyahModel(
          textArabic: savedAyahEntity.textArabic,
          textEnglish: savedAyahEntity.textEnglish,
          taffsir: savedAyahEntity.taffsir,
          ayahNumber: savedAyahEntity.ayahNumber,
          surahArabicName: savedAyahEntity.surahArabicName,
          surahEnglishName: savedAyahEntity.surahEnglishName,
          surahNumber: savedAyahEntity.surahNumber,
        ),
      );
      return Right(unit);
    } on DeleteException catch (ex) {
      return Left(DeleteFailure(message: ex.message));
    } catch (ex) {
      return Left(UnknownFailure(message: ex.toString()));
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  @override
  Future<Either<Failure, List<SavedHadithEntity>>> getSavedHadith() async {
    try {
      List<SavedHadithModel> hadith = await savedDataSource.getSavedHadith();
      List<SavedHadithEntity> hadithEntityList = hadith
          .map(
            (e) => SavedHadithEntity(
              hadithArabic: e.hadithArabic,
              hadithEnglish: e.hadithEnglish,
              status: e.status,
              chapterArabic: e.chapterArabic,
              chapterEnglish: e.chapterEnglish,
              englishNarrator: e.englishNarrator,
              headingArabic: e.headingArabic,
              headingEnglish: e.headingEnglish,
            ),
          )
          .toList();
      return Right(hadithEntityList);
    } on NoSavedException {
      return Left(NoSavedFailure(message: 'no saved exception'));
    } catch (ex) {
      return Left(UnknownFailure(message: 'unknown failure'));
    }
  }

  @override
  Future<Either<Failure, List<SavedSurahEntity>>> getSavedSurah() async {
    try {
      List<SavedSurahModel> suwars = await savedDataSource.getSavedSurah();
      List<SavedSurahEntity> savedSuwars = suwars
          .map(
            (e) => SavedSurahEntity(
              numberSurah: e.numberSurah,
              surahArabicName: e.surahArabicName,
              surahEnglishName: e.surahEnglishName,
              reciterName: e.reciterName,
              mushafeName: e.mushafeName,
              surahUrl: e.surahUrl,
              type: e.type,
              numberVerses: e.numberVerses,
            ),
          )
          .toList();
      return Right(savedSuwars);
    } on NoSavedException {
      return Left(NoSavedFailure(message: 'no saved exception'));
    } catch (ex) {
      return Left(UnknownFailure(message: 'unknown failure'));
    }
  }

  @override
  Future<Either<Failure, List<SavedAyahEntity>>> getSavedVerses() async {
    try {
      List<SavedAyahModel> ayahs = await savedDataSource.getSavedAyah();
      List<SavedAyahEntity> savedAyahs = ayahs
          .map(
            (e) => SavedAyahEntity(
              textArabic: e.textArabic,
              textEnglish: e.textEnglish,
              taffsir: e.taffsir,
              ayahNumber: e.ayahNumber,
              surahArabicName: e.surahArabicName,
              surahEnglishName: e.surahEnglishName,
              surahNumber: e.surahNumber,
            ),
          )
          .toList();
      return Right(savedAyahs);
    } on NoSavedException {
      return Left(NoSavedFailure(message: 'no saved exception'));
    } catch (ex) {
      return Left(UnknownFailure(message: 'unknown failure'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveHadith({
    required SavedHadithEntity hadith,
  }) async {
    try {
      await savedDataSource.saveHadith(
        hadith: SavedHadithModel(
          hadithArabic: hadith.hadithArabic,
          hadithEnglish: hadith.hadithEnglish,
          status: hadith.status,
          chapterArabic: hadith.chapterArabic,
          chapterEnglish: hadith.chapterEnglish,
          englishNarrator: hadith.englishNarrator,
          headingArabic: hadith.headingArabic,
          headingEnglish: hadith.headingEnglish,
        ),
      );
      return Right(unit);
    } catch (ex) {
      return Left(UnknownFailure(message: ex.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSurah({
    required SavedSurahEntity surah,
  }) async {
    try {
      await savedDataSource.saveSurah(
        surah: SavedSurahModel(
          numberSurah: surah.numberSurah,
          surahArabicName: surah.surahArabicName,
          surahEnglishName: surah.surahEnglishName,
          reciterName: surah.reciterName,
          mushafeName: surah.mushafeName,
          surahUrl: surah.surahUrl,
          type: surah.type,
          numberVerses: surah.numberVerses,
        ),
      );
      return Right(unit);
    } on CanNotSavedException {
      return Left(CanNotSavedFailure(message: 'cant saved hadith'));
    } catch (ex) {
      return Left(UnknownFailure(message: 'unknown failure'));
    }
  }

  @override
  Future<Either<Failure, Unit>> saveVerse({
    required SavedAyahEntity verse,
  }) async {
    try {
      await savedDataSource.saveVerse(
        ayah: SavedAyahModel(
          textArabic: verse.textArabic,
          textEnglish: verse.textEnglish,
          taffsir: verse.taffsir,
          ayahNumber: verse.ayahNumber,
          surahArabicName: verse.surahArabicName,
          surahEnglishName: verse.surahEnglishName,
          surahNumber: verse.surahNumber,
        ),
      );
      return Right(unit);
    } on CanNotSavedException {
      return Left(CanNotSavedFailure(message: 'cant saved hadith'));
    } catch (ex) {
      return Left(UnknownFailure(message: 'unknown failure'));
    }
  }
}
