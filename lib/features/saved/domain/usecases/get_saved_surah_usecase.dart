import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_surah_entity.dart';
import 'package:sakina/features/saved/domain/repositories/saved_repo.dart';

class GetSavedSurahUsecase {
  final SavedRepo savedRepo;
  GetSavedSurahUsecase({required this.savedRepo});

  Future<Either<Failure, List<SavedSurahEntity>>> call() async {
    return savedRepo.getSavedSurah();
  }
}
