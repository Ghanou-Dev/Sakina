import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/saved/domain/entitys/saved_ayah_entity.dart';
import 'package:sakina/features/saved/domain/usecases/get_saved_verse_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/remove_verse_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/save_verse_usecase.dart';

part 'saved_ayah_state.dart';

class SavedAyahCubit extends Cubit<SavedAyahState> {
  final SaveVerseUsecase saveVerseUsecase;
  final GetSavedVerseUsecase getSavedVerseUsecase;
  final RemoveVerseUsecase removeVerseUsecase;
  SavedAyahCubit({
    required this.saveVerseUsecase,
    required this.getSavedVerseUsecase,
    required this.removeVerseUsecase,
  }) : super(
         SavedAyahState(failure: '', savedAyahsList: [], savedAyahsKeys: {}),
       );

  Future<void> saveAyah({required SavedAyahEntity ayah}) async {
    Either<Failure, Unit> result = await saveVerseUsecase.call(verse: ayah);
    result.fold(
      (failure) {
        emit(state.copyWith(failure: failure.message));
      },
      (unit) {
        Set<String> savedKeys = Set<String>.from(state.savedAyahsKeys)
          ..add(ayah.textArabic);
        emit(state.copyWith(savedAyahsKeys: savedKeys));
      },
    );
  }

  Future<void> getSavedAyaht() async {
    Either<Failure, List<SavedAyahEntity>> result = await getSavedVerseUsecase
        .call();
    result.fold(
      (failure) {
        emit(state.copyWith(failure: failure.message));
      },
      (savedAyahsList) {
        Set<String> savedKeys = savedAyahsList
            .map(
              (e) => e.textArabic,
            )
            .toSet();
        emit(
          state.copyWith(
            savedAyahsList: savedAyahsList,
            savedAyahsKeys: savedKeys,
          ),
        );
      },
    );
  }

  Future<void> removeSavedAyah({required SavedAyahEntity ayah}) async {
    Either<Failure, Unit> result = await removeVerseUsecase(ayah: ayah);
    result.fold(
      (failure) {
        emit(state.copyWith(failure: failure.message));
      },
      (unit) {
        Set<String> savedKeys = Set<String>.from(state.savedAyahsKeys)
          ..remove(ayah.textArabic);
        emit(state.copyWith(savedAyahsKeys: savedKeys));
      },
    );
  }
}
