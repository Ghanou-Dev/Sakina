import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final int id;
  final String bookName;
  final String writerName;
  final String bookSlug;
  final String hadiths_count;
  final String chapters_count;
  const BookEntity({
    required this.id,
    required this.bookName,
    required this.writerName,
    required this.bookSlug,
    required this.hadiths_count,
    required this.chapters_count,
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
}
