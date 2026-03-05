import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_hadith_entity.dart';
import 'package:sakina/features/saved/domain/repositories/saved_repo.dart';

class GetSavedHadithUsecase {
  final SavedRepo savedRepo;
  GetSavedHadithUsecase({required this.savedRepo});

  Future<Either<Failure, List<SavedHadithEntity>>> call() async {
    return savedRepo.getSavedHadith();
  }
}
