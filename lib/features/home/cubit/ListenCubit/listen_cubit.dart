import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/home/cubit/ListenCubit/listen_state.dart';
import 'package:sakina/features/home/models/reciter_model.dart';
import 'package:sakina/features/home/repositories/quran_audio_repository.dart';

class ListenCubit extends Cubit<ListenState> {
  final QuranAudioRepository quranAudioRepository;
  ListenCubit({required this.quranAudioRepository}) : super(ListenInitial());

  List<ReciterModel> recitersList = [];
  bool recitersDataLoaded = false;
  Future<void> getAllReciters() async {
    if (recitersDataLoaded) {
      return;
    }
    emit(ListenLoading());
    Either<Failure, List<ReciterModel>> data = await quranAudioRepository
        .getReciters();
    data.fold(
      (failure) {
        emit(ListenFailure(failure: failure));
      },
      (reciters) {
        recitersList = reciters;
        emit(ListenLoaded(reciters: reciters));
        recitersDataLoaded = true;
      },
    );
  }
}
