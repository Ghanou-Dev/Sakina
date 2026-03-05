import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_ayah_entity.dart';
import 'package:sakina/features/saved/domain/repositories/saved_repo.dart';

class RemoveVerseUsecase {
  final SavedRepo savedRepo;
  RemoveVerseUsecase({required this.savedRepo});

  Future<Either<Failure, Unit>> call({required SavedAyahEntity ayah}) {
    return savedRepo.removeVerse(savedAyahEntity: ayah);
  }
}
