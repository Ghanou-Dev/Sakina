import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/hadith/domain/entitys/book_entity.dart';
import 'package:sakina/features/hadith/domain/repositories/hadith_repo.dart';

class GetAllBooksUsecase {
  final HadithRepo hadithRepo;
  GetAllBooksUsecase({required this.hadithRepo});

  Future<Either<Failure, List<BookEntity>>> call() async {
    return hadithRepo.getAllBooks();
  }
}
