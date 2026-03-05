import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_ayah_entity.dart';
import 'package:sakina/features/saved/domain/entitys/saved_hadith_entity.dart';
import 'package:sakina/features/saved/domain/entitys/saved_surah_entity.dart';

abstract class SavedRepo {
  Future<Either<Failure, Unit>> saveHadith({required SavedHadithEntity hadith});
  Future<Either<Failure, Unit>> saveVerse({required SavedAyahEntity verse});
  Future<Either<Failure, Unit>> saveSurah({required SavedSurahEntity surah});

  Future<Either<Failure, Unit>> removeHadith({
    required SavedHadithEntity savedHadithEntity,
  });
  Future<Either<Failure, Unit>> removeVerse({
    required SavedAyahEntity savedAyahEntity,
  });
  Future<Either<Failure, Unit>> removeSurah({
    required SavedSurahEntity savedSurahEntity,
  });

  Future<Either<Failure, List<SavedHadithEntity>>> getSavedHadith();
  Future<Either<Failure, List<SavedAyahEntity>>> getSavedVerses();
  Future<Either<Failure, List<SavedSurahEntity>>> getSavedSurah();
}
