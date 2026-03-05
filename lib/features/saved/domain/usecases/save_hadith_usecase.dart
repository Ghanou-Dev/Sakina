import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_hadith_entity.dart';
import 'package:sakina/features/saved/domain/repositories/saved_repo.dart';

class SaveHadithUsecase {
  final SavedRepo savedRepo;
  SaveHadithUsecase({required this.savedRepo});

  Future<Either<Failure, Unit>> call({
    required SavedHadithEntity hadith,
  }) async {
    return savedRepo.saveHadith(hadith: hadith);
  }
}
