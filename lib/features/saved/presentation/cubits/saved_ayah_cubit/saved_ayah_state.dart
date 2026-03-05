part of 'saved_ayah_cubit.dart';

class SavedAyahState {
  final String failure;
  final List<SavedAyahEntity> savedAyahsList;
  final Set<String> savedAyahsKeys;
  SavedAyahState({
    required this.failure,
    required this.savedAyahsList,
    required this.savedAyahsKeys,
  });

  SavedAyahState copyWith({
    String? failure,
    List<SavedAyahEntity>? savedAyahsList,
    Set<String>? savedAyahsKeys,
  }) {
    return SavedAyahState(
      failure: failure ?? this.failure,
      savedAyahsList: savedAyahsList ?? this.savedAyahsList,
      savedAyahsKeys: savedAyahsKeys ?? this.savedAyahsKeys,
    );
  }
}
