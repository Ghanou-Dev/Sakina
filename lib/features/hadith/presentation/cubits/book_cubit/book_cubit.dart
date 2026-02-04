import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/hadith/domain/entitys/book_entity.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_books_usecase.dart';
part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final GetAllBooksUsecase getAllBooksUsecase;
  BookCubit({required this.getAllBooksUsecase}) : super(BookInitial());

  // get all books method //////////////////////////////////////////////////////
  late List<BookEntity> allBooks;
  Future<void> getAllBooks() async {
    emit(BookLoading());
    Either<Failure, List<BookEntity>> getBooks = await getAllBooksUsecase
        .call();
    getBooks.fold(
      (failure) {
        emit(BookFailure());
      },
      (books) {
        allBooks = books;
        emit(BookLoaded(allBooks: books));
      },
    );
  }
}
