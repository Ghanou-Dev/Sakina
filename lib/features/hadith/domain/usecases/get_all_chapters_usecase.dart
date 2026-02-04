import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/hadith/domain/entitys/chapter_entity.dart';
import 'package:sakina/features/hadith/domain/repositories/hadith_repo.dart';

class GetAllChaptersUsecase {
  final HadithRepo hadithRepo;
  const GetAllChaptersUsecase({
    required this.hadithRepo,
  });

  Future<Either<Failure, List<ChapterEntity>>> call({
    required String bookSlug,
  }) async {
    return hadithRepo.getAllChapters(bookSlug: bookSlug);
  }
}
