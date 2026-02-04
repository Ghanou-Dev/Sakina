import 'package:sakina/core/apis/api_consumer.dart';
import 'package:sakina/features/hadith/data/hadith_endpointes.dart';
import 'package:sakina/features/hadith/data/models/book_model.dart';
import 'package:sakina/features/hadith/data/models/chapter_model.dart';
import 'package:sakina/features/hadith/data/models/hadith_model.dart';

abstract class HadithRemoteDataSource {
  Future<List<BookModel>> getAllBooks();
  Future<List<ChapterModel>> getAllChapters({required String bookSlug});
  Future<List<HadithModel>> getAllHadith({
    required String bookSlug,
    required int chapterNumber,
  });
}

class HadithRemoteDataSourceImpl implements HadithRemoteDataSource {
  final ApiConsumer apiConsumer;

  const HadithRemoteDataSourceImpl({
    required this.apiConsumer,
  });
  @override
  Future<List<BookModel>> getAllBooks() async {
    final response = await apiConsumer.get(
      '${HadithEndpointes.baseURL}${HadithEndpointes.books}',
      queryParameters: {
        'apiKey': HadithEndpointes.apiKey,
      },
    );
    List<BookModel> books = (response[HadithEndpointes.books] as List<dynamic>)
        .map((jsonBook) => BookModel.fromJson(jsonBook))
        .toList();
    return books;
  }

  @override
  Future<List<ChapterModel>> getAllChapters({required String bookSlug}) async {
    final response = await apiConsumer.get(
      '${HadithEndpointes.baseURL}$bookSlug/${HadithEndpointes.chapters}',
      queryParameters: {
        'apiKey': HadithEndpointes.apiKey,
      },
    );
    List<ChapterModel> chapters =
        (response[HadithEndpointes.chapters] as List<dynamic>)
            .map((jsonChapter) => ChapterModel.fromJson(jsonChapter))
            .toList();
    return chapters;
  }

  @override
  Future<List<HadithModel>> getAllHadith({
    required String bookSlug,
    required int chapterNumber,
  }) async {
    final response = await apiConsumer.get(
      '${HadithEndpointes.baseURL}${HadithEndpointes.hadiths}/',
      queryParameters: {
        'apiKey': HadithEndpointes.apiKey,
        'book': bookSlug,
        'chapter': chapterNumber,
      },
    );

    List<HadithModel> hadiths =
        (response[HadithEndpointes.hadiths][HadithEndpointes.data]
                as List<dynamic>)
            .map((jsonHadith) => HadithModel.fromJson(jsonHadith))
            .toList();
    return hadiths;
  }
}
