part of 'book_cubit.dart';

abstract class BookState {}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<BookEntity> allBooks;
  BookLoaded({required this.allBooks});
}

class BookFailure extends BookState {}
