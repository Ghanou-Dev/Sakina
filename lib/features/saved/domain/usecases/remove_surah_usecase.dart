import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_surah_entity.dart';
import 'package:sakina/features/saved/domain/repositories/saved_repo.dart';

class RemoveSurahUsecase {
  final SavedRepo savedRepo;
  RemoveSurahUsecase({required this.savedRepo});

  Future<Either<Failure, Unit>> call({required SavedSurahEntity surah}) async {
    return savedRepo.removeSurah(savedSurahEntity: surah);
  }
}
