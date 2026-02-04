import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/hadith/domain/entitys/book_entity.dart';
import 'package:sakina/features/hadith/domain/entitys/chapter_entity.dart';
import 'package:sakina/features/hadith/domain/entitys/hadith_entity.dart';

abstract class HadithRepo {
  Future<Either<Failure, List<BookEntity>>> getAllBooks();

  Future<Either<Failure, List<ChapterEntity>>> getAllChapters({
    required String bookSlug,
  });

  Future<Either<Failure, List<HadithEntity>>> getAllHadiths({
    required String bookSlug,
    required int chapterNumber,
  });
}
