part of 'chapter_cubit.dart';

abstract class ChapterState {}

class ChapterInitial extends ChapterState {}

class ChapterLoading extends ChapterState {}

class ChapterLoaded extends ChapterState {
  final List<ChapterEntity> allChapters;
  ChapterLoaded({required this.allChapters});
}

class ChapterFailure extends ChapterState {}
