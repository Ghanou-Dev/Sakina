import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/features/saved/data/models/saved_ayah_model.dart';
import 'package:sakina/features/saved/data/models/saved_hadith_model.dart';
import 'package:sakina/features/saved/data/models/saved_surah_model.dart';

abstract class SavedDataSource {
  Future<Unit> saveHadith({required SavedHadithModel hadith});
  Future<Unit> saveSurah({required SavedSurahModel surah});
  Future<Unit> saveVerse({required SavedAyahModel ayah});

  Future<Unit> removeHadith({required SavedHadithModel hadith});
  Future<Unit> removeVerse({required SavedAyahModel ayah});
  Future<Unit> removeSurah({required SavedSurahModel surah});

  Future<List<SavedHadithModel>> getSavedHadith();
  Future<List<SavedSurahModel>> getSavedSurah();
  Future<List<SavedAyahModel>> getSavedAyah();
}

class SavedDataSourceImpl implements SavedDataSource {
  final Box<SavedAyahModel> boxVerse;
  final Box<SavedHadithModel> boxHadith;
  final Box<SavedSurahModel> boxSurah;
  SavedDataSourceImpl({
    required this.boxVerse,
    required this.boxHadith,
    required this.boxSurah,
  });

  @override
  Future<Unit> removeHadith({required SavedHadithModel hadith}) async {
    try {
      final allSavedHadiths = boxHadith.values.toList();
      final SavedHadithModel removeHadith = allSavedHadiths.firstWhere(
        (h) => h.hadithArabic == hadith.hadithArabic,
      );
      await removeHadith.delete();
      return Future.value(unit);
    } catch (ex) {
      throw DeleteException(message: ex.toString());
    }
  }

  @override
  Future<Unit> removeSurah({required SavedSurahModel surah}) async {
    try {
      final allSavedSuwars = boxSurah.values.toList();
      SavedSurahModel removeSurah = allSavedSuwars.firstWhere(
        (s) =>
            s.surahEnglishName == surah.surahEnglishName &&
            s.reciterName == surah.reciterName &&
            s.mushafeName == surah.mushafeName,
      );
      await removeSurah.delete();
      return Future.value(unit);
    } catch (ex) {
      throw DeleteException(message: ex.toString());
    }
  }

  @override
  Future<Unit> removeVerse({required SavedAyahModel ayah}) async {
    try {
      final allSavedAyahs = boxVerse.values.toList();
      SavedAyahModel removeAyah = allSavedAyahs.firstWhere(
        (a) => a.textArabic == ayah.textArabic,
      );
      await removeAyah.delete();
      return Future.value(unit);
    } catch (ex) {
      throw DeleteException(message: ex.toString());
    }
  }

  //////////////////////////////////////////////////////////////////////////////

  @override
  Future<List<SavedAyahModel>> getSavedAyah() {
    try {
      List<SavedAyahModel> savedAyah = boxVerse.values.toList();
      return Future.value(savedAyah);
    } catch (er) {
      throw NoSavedException(message: er.toString());
    }
  }

  @override
  Future<List<SavedHadithModel>> getSavedHadith() {
    try {
      List<SavedHadithModel> savedHadith = boxHadith.values.toList();
      return Future.value(savedHadith);
    } catch (er) {
      throw NoSavedException(message: er.toString());
    }
  }

  @override
  Future<List<SavedSurahModel>> getSavedSurah() {
    try {
      List<SavedSurahModel> savedSuwars = boxSurah.values.toList();
      return Future.value(savedSuwars);
    } catch (er) {
      throw NoSavedException(message: er.toString());
    }
  }

  @override
  Future<Unit> saveHadith({required SavedHadithModel hadith}) async {
    try {
      await boxHadith.add(hadith);
      return Future.value(unit);
    } catch (er) {
      throw CanNotSavedException(message: er.toString());
    }
  }

  @override
  Future<Unit> saveSurah({required SavedSurahModel surah}) async {
    try {
      await boxSurah.add(
        surah,
      );
      return Future.value(unit);
    } catch (er) {
      throw CanNotSavedException(message: er.toString());
    }
  }

  @override
  Future<Unit> saveVerse({required SavedAyahModel ayah}) async {
    try {
      await boxVerse.add(ayah);
      return Future.value(unit);
    } catch (er) {
      throw CanNotSavedException(message: er.toString());
    }
  }
}
