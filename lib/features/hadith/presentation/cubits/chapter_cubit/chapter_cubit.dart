import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/hadith/domain/entitys/chapter_entity.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_chapters_usecase.dart';

part 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  final GetAllChaptersUsecase getAllChaptersUsecase;
  ChapterCubit({required this.getAllChaptersUsecase}) : super(ChapterInitial());

  // get all chapters method ///////////////////////////////////////////////////
  late List<ChapterEntity> allChapters;
  String selectedChapterName = '';
  Future<void> getAllChapters({
    required String bookSlug,
  }) async {
    emit(ChapterLoading());
    Either<Failure, List<ChapterEntity>> getChapters =
        await getAllChaptersUsecase.call(bookSlug: bookSlug);
    getChapters.fold(
      (failure) {
        emit(ChapterFailure());
      },
      (chapters) {
        allChapters = chapters;
        emit(ChapterLoaded(allChapters: chapters));
      },
    );
  }
}
