import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sakina/models/reciter_chikh_model.dart';
import 'package:sakina/models/surah_model.dart';
import 'package:sakina/cubits/HomeCubit/home_state.dart';
import 'package:sakina/services/get_all_reciers.dart';
import 'package:sakina/services/get_all_suwars.dart';
import 'package:sakina/widgets/custom_item_surah.dart';
import 'package:sakina/widgets/reciter_chikh_item.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  late List<CustomItemSurah> suwars;
  late List<CustomItemSurah> suwarsEnglish;

  Future<void> getSuwars() async {
    emit(HomeLoading());
    final List<SurahModel> listSuwars = await GetAllSuwars.suwars(
      identifir: 'ar.abdurrahmaansudais',
    );
    final List<SurahModel> listSuwarsEnglish = await GetAllSuwars.suwars(
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
      HomeLoadedSuwars(
        customItemSuwars: suwars,
        customItemSuwarsEnglish: suwarsEnglish,
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
}
