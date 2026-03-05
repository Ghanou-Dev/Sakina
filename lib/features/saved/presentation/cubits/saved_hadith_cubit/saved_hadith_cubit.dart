import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_hadith_entity.dart';
import 'package:sakina/features/saved/domain/usecases/get_saved_hadith_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/remove_hadith_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/save_hadith_usecase.dart';
part 'saved_hadith_state.dart';

class SavedHadithCubit extends Cubit<SavedHadithState> {
  final SaveHadithUsecase saveHadithUsecase;
  final GetSavedHadithUsecase getSavedHadithUsecase;
  final RemoveHadithUsecase removeHadithUsecase;
  SavedHadithCubit({
    required this.saveHadithUsecase,
    required this.getSavedHadithUsecase,
    required this.removeHadithUsecase,
  }) : super(SavedHadithState(savedHadiths: [], savedIds: [])) {
    loadSavedData();
  }

  Future<void> loadSavedData() async {
    await getSavedHadith();
  }

  // manage hadiths
  Future<void> saveHadith({required SavedHadithEntity hadith}) async {
    Either<Failure, Unit> status = await saveHadithUsecase.call(hadith: hadith);
    status.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
      (unit) {
        List<String> update = List<String>.from(state.savedIds)
          ..add(hadith.hadithArabic);
        emit(state.copyWith(savedIds: update));
      },
    );
  }

  Future<void> removeHadith({required SavedHadithEntity hadith}) async {
    Either<Failure, Unit> status = await removeHadithUsecase.call(
      hadith: hadith,
    );
    status.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
      (unit) {
        List<String> update = List<String>.from(state.savedIds)
          ..remove(hadith.hadithArabic);
        emit(state.copyWith(savedIds: update));
      },
    );
  }

  Future<void> getSavedHadith() async {
    state.copyWith(isLoading: true);
    final Either<Failure, List<SavedHadithEntity>> status =
        await getSavedHadithUsecase.call();
    status.fold(
      (failure) {
        emit(state.copyWith(errorMessage: failure.message));
      },
      (savedHadithsList) {
        emit(
          state.copyWith(
            savedHadiths: savedHadithsList,
            savedIds: savedHadithsList
                .map((hadith) => hadith.hadithArabic)
                .toList(),
            isLoading: false,
          ),
        );
      },
    );
  }
}
