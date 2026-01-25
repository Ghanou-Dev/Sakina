import 'package:sakina/features/home/models/taffsir_surah_model.dart';

class TaffsirState {}

class TaffsirInit extends TaffsirState {}

class TaffsirLoading extends TaffsirState {}

class TaffsirLoaded extends TaffsirState {
  final List<TaffsirSurahModel> taffsirList;
  TaffsirLoaded({
    required this.taffsirList,
  });
}
