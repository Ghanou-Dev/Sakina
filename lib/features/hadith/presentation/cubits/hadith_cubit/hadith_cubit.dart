import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/hadith/domain/entitys/hadith_entity.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_hadiths_usecase.dart';

part 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  final GetAllHadithsUsecase getAllHadithsUsecase;
  HadithCubit({
    required this.getAllHadithsUsecase,
  }) : super(HadithInitial());

  // get all hadiths method ////////////////////////////////////////////////////
  late List<HadithEntity> allHadiths;
  Future<void> getAllHadiths({
    required String bookSlug,
    required int chapterNumber,
  }) async {
    emit(HadithLoading());
    Either<Failure, List<HadithEntity>> getHadiths = await getAllHadithsUsecase
        .call(
          bookSlug: bookSlug,
          chapterNumber: chapterNumber,
        );
    getHadiths.fold(
      (failure) {
        emit(HadithFailure());
      },
      (hadiths) {
        allHadiths = hadiths;
        emit(
          HadithLoaded(
            allHadiths: hadiths,
          ),
        );
      },
    );
  }
}
