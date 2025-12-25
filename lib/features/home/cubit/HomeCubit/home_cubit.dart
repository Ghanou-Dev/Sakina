import 'dart:async';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/home/models/audio_model.dart';
import 'package:sakina/features/home/models/surah_info_model.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_state.dart';
import 'package:sakina/features/home/models/surah_model.dart';
import 'package:sakina/features/home/repositories/quran_repository.dart';
import 'package:sakina/features/home/widgets/item_surah_info.dart';

class HomeCubit extends Cubit<HomeState> {
  final QuranRepository quranRepo;
  HomeCubit({required this.quranRepo}) : super(HomeInitial());

  bool isTapped = false;

  late List<ItemSurahInfo> allSuwarsInfo;
  int index = 0;
  Future<void> getSuwarsInfo() async {
    // emit(HomeLoading());
    Either<Failure, List<SurahInfoModel>> data = await quranRepo
        .getSuwarsInfo();
    // await Future.delayed(Duration(seconds: 2));
    data.fold(
      (failure) {
        emit(HomeFailure(failure: failure));
      },
      (quranDAta) {
        allSuwarsInfo = quranDAta.map((surah) {
          index++;
          return ItemSurahInfo(
            index: index,
            surahName: surah.surahName,
            surahNameArabic: surah.surahNameArabic,
            surahNameArabicLong: surah.surahNameArabicLong,
            surahNameTranslation: surah.surahNameTranslation,
            revelationPlace: surah.revelationPlace,
            totalAyah: surah.totalAyah,
          );
        }).toList();

        emit(HomeInfoSuwarsLoaded(infoSuwars: allSuwarsInfo));
      },
    );
  }

  late SurahModel specialSurah;
  Future<void> getSpecialSurah({required int surahNumber}) async {
    emit(HomeSurahLoading());
    final data = await quranRepo.getSpecialSurah(surahNumber: surahNumber);
    data.fold(
      (failure) {},
      (sura) {
        specialSurah = SurahModel(
          surahName: sura.surahName,
          surahNameArabic: sura.surahNameArabic,
          surahNameArabicLong: sura.surahNameArabicLong,
          surahNameTranslation: sura.surahNameTranslation,
          revelationPlace: sura.revelationPlace,
          totalAyah: sura.totalAyah,
          surahNo: sura.surahNo,
          audio: sura.audio,
          english: sura.english,
          arabic1: sura.arabic1,
          arabic2: sura.arabic2,
          bengali: sura.bengali,
          urdu: sura.urdu,
        );
      },
    );
    emit(HomeSurahLoaded(surah: specialSurah));
  }

  late AudioModel audioAyah;
  late int ayahNumber;
  Future<void> getSpecialAyahAudio({
    required int surahNo,
    required int ayahNo,
  }) async {
    emit(HomeAyahLoading());
    final data = await quranRepo.getSpecialAyahAudio(
      surahNo: surahNo,
      ayahNo: ayahNo,
    );
    ayahNumber = ayahNo;
    data.fold(
      (failure) {
        log('error loading aya audio');
      },
      (ayah) {
        audioAyah = ayah;

        emit(HomeAyahLoaded(ayahAudio: audioAyah));
      },
    );
  }

  //////////////////////////////////////////////////////////////////////////////

  // create map for saved scroll offset
  final Map<String, double> _savedScrollOffsets = {};

  void saveOffset(String surahName, double offset) {
    _savedScrollOffsets[surahName] = offset;
  }

  double getOffset(String surahName) {
    return _savedScrollOffsets[surahName] ?? 0.0;
  }
}
