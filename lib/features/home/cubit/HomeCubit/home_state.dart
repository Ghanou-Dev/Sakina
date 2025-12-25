import 'package:sakina/core/errors/failurs.dart';
import 'package:sakina/features/home/models/audio_model.dart';
import 'package:sakina/features/home/models/surah_model.dart';
import 'package:sakina/features/home/widgets/item_surah_info.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSurahLoading extends HomeState {}

class HomeAyahLoading extends HomeState {}

class HomeChangeAyahNumber extends HomeState {
  int ayahNumber;
  HomeChangeAyahNumber({required this.ayahNumber});
}

class HomeInfoSuwarsLoaded extends HomeState {
  List<ItemSurahInfo> infoSuwars;
  HomeInfoSuwarsLoaded({required this.infoSuwars});
}

class HomeSurahLoaded extends HomeState {
  SurahModel surah;
  HomeSurahLoaded({required this.surah});
}

class HomeAyahLoaded extends HomeState {
  AudioModel ayahAudio;
  HomeAyahLoaded({required this.ayahAudio});
}

class HomeFailure extends HomeState {
  Failure failure;
  HomeFailure({required this.failure});
}
