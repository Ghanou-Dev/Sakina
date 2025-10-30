import 'package:flutter_bloc/flutter_bloc.dart';
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
    final List<SurahModel> listSuwars = await GetAllSuwarsWithIdentifir.call(
      identifir: 'ar.abdurrahmaansudais',
    );
    final List<SurahModel> listSuwarsEnglish =
        await GetAllSuwarsWithIdentifir.call(
          identifir: 'en.asad',
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
      ),
    );
  }

  // get taffsir of all suwars in quran
  List<CustomItemSurah> taffsirOffAllSuwars = [];
  Future<void> getTaffsirOfAllSuwars() async {
    List<SurahModel> taffsirSuwars = await GetAllSuwarsWithIdentifir.call(
      identifir: 'ar.muyassar',
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
      ),
    );
  }

  late List<ReciterChikhItem> reciterChikhs;
  Future<void> getAudioSuwars() async {
    int index = 0;
    List<ReciterChikhModel> reciterChikhList =
        await GetAllReciers.getReciters();
    reciterChikhs = reciterChikhList.map((chikh) {
      index++;
      return ReciterChikhItem(
        chikh: chikh,
        index: index,
      );
    }).toList();
  }

  // create map for saved scroll offset
  Map<String, double> _savedScrollOffsets = {};

  void saveOffset(String surahName, double offset) {
    _savedScrollOffsets[surahName] = offset;
  }

  double getOffset(String surahName) {
    return _savedScrollOffsets[surahName] ?? 0.0;
  }
}
