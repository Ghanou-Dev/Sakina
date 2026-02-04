import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/hadith/domain/entitys/hadith_entity.dart';
import 'package:sakina/features/hadith/domain/repositories/hadith_repo.dart';

class GetAllHadithsUsecase {
  final HadithRepo hadithRepo;
  GetAllHadithsUsecase({required this.hadithRepo});

  Future<Either<Failure, List<HadithEntity>>> call({
    required String bookSlug,
    required int chapterNumber,
  }) async {
    return hadithRepo.getAllHadiths(
      bookSlug: bookSlug,
      chapterNumber: chapterNumber,
    );
  }
}
