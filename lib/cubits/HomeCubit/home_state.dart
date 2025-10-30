import 'package:sakina/widgets/custom_item_surah.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDataLoaded extends HomeState {
  final List<CustomItemSurah> customItemSuwars;
  final List<CustomItemSurah> customItemSuwarsEnglish;
  final List<CustomItemSurah> taffsirOffAllSuwars;
  HomeDataLoaded({
    required this.customItemSuwars,
    required this.customItemSuwarsEnglish,
    required this.taffsirOffAllSuwars,
  });
}
