import 'package:dartz/dartz.dart';
import 'package:sakina/core/errors/exceptions.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/home/models/taffsir_surah_model.dart';
import 'package:sakina/features/home/services/get_taffsir_of_qurane_service.dart';

class TaffsirRepo {
  final GetTaffsirOfQuranService taffsirService;
  TaffsirRepo({
    required this.taffsirService,
  });

  Future<Either<Failure, List<TaffsirSurahModel>>> getTafsir() async {
    try {
      List<TaffsirSurahModel> tafsir = await taffsirService.call();
      return Right(tafsir);
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
