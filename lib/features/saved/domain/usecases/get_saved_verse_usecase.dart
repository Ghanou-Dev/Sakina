import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_ayah_entity.dart';
import 'package:sakina/features/saved/domain/repositories/saved_repo.dart';

class GetSavedVerseUsecase {
  final SavedRepo savedRepo;
  GetSavedVerseUsecase({required this.savedRepo});

  Future<Either<Failure, List<SavedAyahEntity>>> call() async {
    return savedRepo.getSavedVerses();
  }
}
