import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/core/services/quran_services/qurane_audio_service.dart';
import 'package:sakina/features/home/models/moshafe_model.dart';
import 'package:sakina/features/home/models/reciter_model.dart';

class QuranAudioRepository {
  final QuraneAudioService quraneAudioService;
  QuranAudioRepository({required this.quraneAudioService});

  Future<Either<Failure, List<ReciterModel>>> getReciters() async {
    try {
      final reciters = (await quraneAudioService.fetchAllReciters())
          .map(
            (r) => ReciterModel(
              id: r.id,
              name: r.name,
              date: r.date,
              letter: r.letter,
              moshaf: r.moshaf
                  .map(
                    (moshaf) => MoshafeModel(
                      id: moshaf.id,
                      name: moshaf.name,
                      server: moshaf.server,
                      surahTotal: moshaf.surahTotal,
                      moshafType: moshaf.moshafType,
                      surahList: moshaf.surahList,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList();
      return Right(reciters);
    } on InternetTimeoutEception catch (e) {
      return Left(TimeoutFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on NoInternetException catch (e) {
      return Left(NoInternetFailure(message: e.message));
    } on CancelException catch (e) {
      return Left(CancelFailure(message: e.message));
    } on UnknownException catch (e) {
      return Left(UnknownFailure(message: e.message));
    }
  }
}
