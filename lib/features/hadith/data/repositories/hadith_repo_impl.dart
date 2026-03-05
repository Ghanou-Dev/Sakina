import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/hadith/data/data_sources/hadith_remote_data_source.dart';
import 'package:sakina/features/hadith/data/models/book_model.dart';
import 'package:sakina/features/hadith/data/models/chapter_model.dart';
import 'package:sakina/features/hadith/data/models/hadith_model.dart';
import 'package:sakina/features/hadith/domain/entitys/book_entity.dart';
import 'package:sakina/features/hadith/domain/entitys/chapter_entity.dart';
import 'package:sakina/features/hadith/domain/entitys/hadith_entity.dart';
import 'package:sakina/features/hadith/domain/repositories/hadith_repo.dart';

class HadithRepoImpl implements HadithRepo {
  final HadithRemoteDataSource remoteDataSource;
  const HadithRepoImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, List<BookEntity>>> getAllBooks() async {
    try {
      List<BookModel> allBooks = await remoteDataSource.getAllBooks();
      return Right(allBooks);
    } on InternetTimeoutEception catch (er) {
      return Left(TimeoutFailure(message: er.message ?? 'Timeout failure'));
    } on ServerException catch (er) {
      return Left(ServerFailure(message: er.message));
    } on CancelException catch (er) {
      return Left(CancelFailure(message: er.message));
    } on NoInternetException catch (er) {
      return Left(NoInternetFailure(message: er.message));
    } on UnknownException catch (er) {
      return Left(UnknownFailure(message: er.message));
    } catch (er) {
      return Left(UnknownFailure(message: 'UnknownFailure'));
    }
  }

  @override
  Future<Either<Failure, List<ChapterEntity>>> getAllChapters({
    required String bookSlug,
  }) async {
    try {
      List<ChapterModel> chapters = await remoteDataSource.getAllChapters(
        bookSlug: bookSlug,
      );
      return Right(chapters);
    } on InternetTimeoutEception catch (er) {
      return Left(TimeoutFailure(message: er.message ?? 'Timeout failure'));
    } on ServerException catch (er) {
      return Left(ServerFailure(message: er.message));
    } on CancelException catch (er) {
      return Left(CancelFailure(message: er.message));
    } on NoInternetException catch (er) {
      return Left(NoInternetFailure(message: er.message));
    } on UnknownException catch (er) {
      return Left(UnknownFailure(message: er.message));
    } catch (er) {
      return Left(UnknownFailure(message: 'UnknownFailure'));
    }
  }

  @override
  Future<Either<Failure, List<HadithEntity>>> getAllHadiths({
    required String bookSlug,
    required int chapterNumber,
  }) async {
    try {
      List<HadithModel> hadiths = await remoteDataSource.getAllHadith(
        bookSlug: bookSlug,
        chapterNumber: chapterNumber,
      );
      return Right(hadiths);
    } on InternetTimeoutEception catch (er) {
      return Left(TimeoutFailure(message: er.message ?? 'TimeoutFailure'));
    } on ServerException catch (er) {
      return Left(ServerFailure(message: er.message));
    } on CancelException catch (er) {
      return Left(CancelFailure(message: er.message));
    } on NoInternetException catch (er) {
      return Left(NoInternetFailure(message: er.message));
    } on UnknownException catch (er) {
      return Left(UnknownFailure(message: er.message));
    } catch (er) {
      return Left(UnknownFailure(message: 'UnknownFailure'));
    }
  }
}
