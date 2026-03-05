part of 'saved_hadith_cubit.dart';

class SavedHadithState {
  final List<SavedHadithEntity> savedHadiths;
  final List<String> savedIds;
  final bool isLoading;
  final String? errorMessage;
  SavedHadithState({
    required this.savedHadiths,
    required this.savedIds,
    this.isLoading = false,
    this.errorMessage,
  });

  SavedHadithState copyWith({
    List<SavedHadithEntity>? savedHadiths,
    List<String>? savedIds,
    bool? isLoading,
    String? errorMessage,
  }) {
    return SavedHadithState(
      savedHadiths: savedHadiths ?? this.savedHadiths,
      savedIds: savedIds ?? this.savedIds,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
