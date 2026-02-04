import 'package:sakina/features/hadith/data/hadith_endpointes.dart';
import 'package:sakina/features/hadith/domain/entitys/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.bookName,
    required super.writerName,
    required super.bookSlug,
    required super.hadiths_count,
    required super.chapters_count,
  });

  @override
  List<Object?> get props => [
    id,
    bookName,
    writerName,
    bookSlug,
    hadiths_count,
    chapters_count,
  ];

  factory BookModel.fromJson(jsonData) {
    return BookModel(
      id: jsonData[HadithEndpointes.id],
      bookName: jsonData[HadithEndpointes.bookName],
      writerName: jsonData[HadithEndpointes.writerName],
      bookSlug: jsonData[HadithEndpointes.bookSlug],
      hadiths_count: jsonData[HadithEndpointes.hadiths_count],
      chapters_count: jsonData[HadithEndpointes.chapters_count],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      HadithEndpointes.id: id,
      HadithEndpointes.bookName: bookName,
      HadithEndpointes.writerName: writerName,
      HadithEndpointes.bookSlug: bookSlug,
      HadithEndpointes.hadiths_count: hadiths_count,
      HadithEndpointes.chapters_count: chapters_count,
    };
  }
}
