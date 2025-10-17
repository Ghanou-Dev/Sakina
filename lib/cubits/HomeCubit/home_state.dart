import 'package:sakina/widgets/custom_item_surah.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoadedSuwars extends HomeState {
  final List<CustomItemSurah> customItemSuwars;
  final List<CustomItemSurah> customItemSuwarsEnglish;
  HomeLoadedSuwars({
    required this.customItemSuwars,
    required this.customItemSuwarsEnglish,
  });
}


