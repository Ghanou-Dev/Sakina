import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/features/home/cubit/TaffsirCubit/taffsir_state.dart';
import 'package:sakina/features/home/models/taffsir_surah_model.dart';
import 'package:sakina/features/home/repositories/taffsir_repo.dart';

class TaffsirCubit extends Cubit<TaffsirState> {
  final TaffsirRepo taffsirRepo;
  TaffsirCubit({required this.taffsirRepo}) : super(TaffsirInit());

  late List<TaffsirSurahModel> tafsirList;
  Future<void> getTaffsir() async {
    emit(TaffsirLoading());
    final data = await taffsirRepo.getTafsir();
    data.fold((failure) {}, (taffsir) {
      tafsirList = taffsir;
      emit(TaffsirLoaded(taffsirList: taffsir));
    });
  }
}
