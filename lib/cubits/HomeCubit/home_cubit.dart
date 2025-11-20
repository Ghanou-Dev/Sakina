import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/errors/internet_exceptions.dart';
import 'package:sakina/models/reciter_chikh_model.dart';
import 'package:sakina/models/surah_model.dart';
import 'package:sakina/cubits/HomeCubit/home_state.dart';
import 'package:sakina/services/get_all_reciers.dart';
import 'package:sakina/services/get_all_suwars_with_identifir.dart';
import 'package:sakina/widgets/custom_item_surah.dart';
import 'package:sakina/widgets/reciter_chikh_item.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  late List<CustomItemSurah> suwars;
  late List<CustomItemSurah> suwarsEnglish;

  Future<void> getSuwars() async {
    emit(HomeLoading());

    try {
      final List<SurahModel> listSuwars =
          await GetAllSuwarsWithIdentifir.call(
            identifir: 'ar.abdurrahmaansudais',
          ).timeout(
            Duration(seconds: 40),
            onTimeout: () {
              throw InternetTimeoutEception(message: '');
            },
          );
      suwars = listSuwars
          .map(
            (item) => CustomItemSurah(
              number: item.number,
              name: item.name,
              englishName: item.englishName,
              englishNameTranslation: item.englishNameTranslation,
              revelationType: item.revelationType,
              ayahs: item.ayahs,
            ),
          )
          .toList();
    } on InternetTimeoutEception catch (e) {
      print('[LOG]: $e');
      emit(
        HomeTimeoutFailure(
          message: 'Your Internet Connection is wake! Try again later',
        ),
      );
    } on NoInternetException catch (e) {
      print('[LOG]: $e');
      emit(HomeFailure(message: 'No Internet!'));
    } catch (e) {
      print('[LOG]: $e');
      emit(HomeFailure(message: 'Error! Try again later'));
    }

    try {
      final List<SurahModel> listSuwarsEnglish =
          await GetAllSuwarsWithIdentifir.call(
            identifir: 'en.asad',
          ).timeout(
            Duration(seconds: 40),
            onTimeout: () {
              throw InternetTimeoutEception(message: 'Timeout exception');
            },
          );
      suwarsEnglish = listSuwarsEnglish
          .map(
            (item) => CustomItemSurah(
              number: item.number,
              name: item.name,
              englishName: item.englishName,
              englishNameTranslation: item.englishNameTranslation,
              revelationType: item.revelationType,
              ayahs: item.ayahs,
            ),
          )
          .toList();

      emit(
        HomeDataLoaded(
          customItemSuwars: suwars,
          customItemSuwarsEnglish: suwarsEnglish,
          taffsirOffAllSuwars: [],
          reciterChikhs: [],
        ),
      );
    } on InternetTimeoutEception catch (e) {
      print('[LOG]: $e');
      emit(
        HomeTimeoutFailure(message: 'Please check your network and try again!'),
      );
    } on NoInternetException catch (e) {
      print('[LOG]: $e');
      emit(HomeFailure(message: 'No Internet!'));
    } catch (e) {
      print('[LOG]: $e');
      emit(HomeFailure(message: 'Error! Try again later'));
    }
  }

  // get taffsir of all suwars in quran
  List<CustomItemSurah> taffsirOffAllSuwars = [];
  Future<void> getTaffsirOfAllSuwars() async {
    try {
      List<SurahModel> taffsirSuwars =
          await GetAllSuwarsWithIdentifir.call(
            identifir: 'ar.muyassar',
          ).timeout(
            Duration(seconds: 40),
            onTimeout: () {
              throw InternetTimeoutEception(
                message: 'Internet conections State is Wake!',
              );
            },
          );
      taffsirOffAllSuwars = taffsirSuwars
          .map(
            (surah) => CustomItemSurah(
              number: surah.number,
              name: surah.name,
              englishName: surah.englishName,
              englishNameTranslation: surah.englishNameTranslation,
              revelationType: surah.revelationType,
              ayahs: surah.ayahs,
            ),
          )
          .toList();
      emit(
        HomeDataLoaded(
          customItemSuwars: suwars,
          customItemSuwarsEnglish: suwarsEnglish,
          taffsirOffAllSuwars: taffsirOffAllSuwars,
          reciterChikhs: reciterChikhs,
        ),
      );
      log('Taffsir of all suwars has loaded');
    } on InternetTimeoutEception catch (e) {
      print(e);
      emit(HomeTimeoutFailure(message: 'Timeout Exceotion !'));
    } on NoInternetException catch (e) {
      emit(HomeFailure(message: e.message));
    } catch (e) {
      emit(HomeFailure(message: 'Error : $e'));
    }
  }

  late List<ReciterChikhItem> reciterChikhs;
  Future<void> getAudioSuwars() async {
    int index = 0;
    try {
      List<ReciterChikhModel> reciterChikhList =
          await GetAllReciers.getReciters().timeout(
            Duration(seconds: 40),
            onTimeout: () {
              throw InternetTimeoutEception(message: 'Timeout Exception');
            },
          );
      reciterChikhs = reciterChikhList.map((chikh) {
        index++;
        return ReciterChikhItem(
          chikh: chikh,
          index: index,
        );
      }).toList();
      emit(
        HomeDataLoaded(
          customItemSuwars: suwars,
          customItemSuwarsEnglish: suwarsEnglish,
          taffsirOffAllSuwars: taffsirOffAllSuwars,
          reciterChikhs: reciterChikhs,
        ),
      );
    } on InternetTimeoutEception catch (e) {
      print(e);
      emit(HomeTimeoutFailure(message: 'Timeout Exception'));
    } on NoInternetException catch (e) {
      emit(HomeFailure(message: e.message));
    } catch (e) {
      emit(HomeFailure(message: '[ERROR] : $e '));
    }
  }

  // create map for saved scroll offset
  final Map<String, double> _savedScrollOffsets = {};

  void saveOffset(String surahName, double offset) {
    _savedScrollOffsets[surahName] = offset;
  }

  double getOffset(String surahName) {
    return _savedScrollOffsets[surahName] ?? 0.0;
  }
}
