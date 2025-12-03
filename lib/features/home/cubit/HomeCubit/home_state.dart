import 'package:sakina/features/home/widgets/custom_item_surah.dart';
import 'package:sakina/features/home/widgets/reciter_chikh_item.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeDataLoaded extends HomeState {
  final List<CustomItemSurah> customItemSuwars;
  final List<CustomItemSurah> customItemSuwarsEnglish;
  final List<CustomItemSurah> taffsirOffAllSuwars;
  final List<ReciterChikhItem> reciterChikhs;
  HomeDataLoaded({
    required this.customItemSuwars,
    required this.customItemSuwarsEnglish,
    required this.reciterChikhs,
    required this.taffsirOffAllSuwars,
  });
}

class HomeFailure extends HomeState {
  final String message;
  HomeFailure({required this.message});
}

class HomeTimeoutFailure extends HomeState {
  final String message;
  HomeTimeoutFailure({required this.message});
}
