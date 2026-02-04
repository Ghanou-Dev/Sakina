part of 'hadith_cubit.dart';

abstract class HadithState {}

class HadithInitial extends HadithState {}

class HadithLoading extends HadithState {}

class HadithLoaded extends HadithState {
  final List<HadithEntity> allHadiths;
  HadithLoaded({required this.allHadiths});
}

class HadithFailure extends HadithState {}
