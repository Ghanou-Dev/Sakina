import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:sakina/core/apis/api_consumer.dart';
import 'package:sakina/core/apis/dio_consumer.dart';
import 'package:sakina/core/connection/data/repositories/connection_repo_impl.dart';
import 'package:sakina/core/connection/domain/repositories/connection_repo.dart';
import 'package:sakina/core/connection/domain/usecases/get_connection_status_usecase.dart';
import 'package:sakina/core/connection/domain/usecases/listen_to_connection_status.dart';
import 'package:sakina/core/connection/presentation/cubit/network_cubit.dart';
import 'package:sakina/core/services/quran_services/qurane_audio_service.dart';
import 'package:sakina/core/services/quran_services/qurane_service.dart';
import 'package:sakina/features/hadith/data/data_sources/hadith_remote_data_source.dart';
import 'package:sakina/features/hadith/data/repositories/hadith_repo_impl.dart';
import 'package:sakina/features/hadith/domain/repositories/hadith_repo.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_books_usecase.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_chapters_usecase.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_hadiths_usecase.dart';
import 'package:sakina/features/hadith/presentation/cubits/book_cubit/book_cubit.dart';
import 'package:sakina/features/hadith/presentation/cubits/chapter_cubit/chapter_cubit.dart';
import 'package:sakina/features/hadith/presentation/cubits/hadith_cubit/hadith_cubit.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/cubit/ListenCubit/listen_cubit.dart';
import 'package:sakina/features/home/cubit/TaffsirCubit/taffsir_cubit.dart';
import 'package:sakina/features/home/repositories/quran_audio_repository.dart';
import 'package:sakina/features/home/repositories/quran_repoo.dart';
import 'package:sakina/features/home/repositories/taffsir_repo.dart';
import 'package:sakina/features/home/services/get_taffsir_of_qurane_service.dart';
import 'package:sakina/features/prayer/data/repositories/prayer_repo_impl.dart';
import 'package:sakina/features/prayer/data/srcs/location_data_src.dart';
import 'package:sakina/features/prayer/data/srcs/prayer_times_data_src.dart';
import 'package:sakina/features/prayer/domain/repositories/prayer_repo.dart';
import 'package:sakina/features/prayer/domain/usecases/get_location_usecase.dart';
import 'package:sakina/features/prayer/domain/usecases/get_prayer_times_usecase.dart';
import 'package:sakina/features/prayer/presentation/cubits/location_cubit/location_cubit.dart';
import 'package:sakina/features/prayer/presentation/cubits/prayer_cubit/prayer_cubit.dart';
import 'package:sakina/features/saved/data/data_sources/saved_data_source.dart';
import 'package:sakina/features/saved/data/models/saved_ayah_model.dart';
import 'package:sakina/features/saved/data/models/saved_hadith_model.dart';
import 'package:sakina/features/saved/data/models/saved_surah_model.dart';
import 'package:sakina/features/saved/data/repositories/saved_repo_impl.dart';
import 'package:sakina/features/saved/domain/repositories/saved_repo.dart';
import 'package:sakina/features/saved/domain/usecases/get_saved_hadith_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/get_saved_verse_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/remove_hadith_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/remove_verse_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/save_hadith_usecase.dart';
import 'package:sakina/features/saved/domain/usecases/save_verse_usecase.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_ayah_cubit/saved_ayah_cubit.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_hadith_cubit/saved_hadith_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //// features
  /// Prayer Cubit //////////////////////////////////////////////////////////////
  sl.registerFactory<PrayerCubit>(
    () => PrayerCubit(getPrayerTimesUsecase: sl<GetPrayerTimesUsecase>()),
  );
  // usecase
  sl.registerLazySingleton<GetPrayerTimesUsecase>(
    () => GetPrayerTimesUsecase(prayerRepo: sl<PrayerRepo>()),
  );
  //

  /// Location Cubit ////////////////////////////////////////////////////////////
  sl.registerFactory<LocationCubit>(
    () => LocationCubit(
      getLocationUsecase: sl<GetLocationUsecase>(),
    ),
  );
  // usecases
  sl.registerLazySingleton<GetLocationUsecase>(
    () => GetLocationUsecase(prayerRepo: sl<PrayerRepo>()),
  );

  // repositories
  sl.registerLazySingleton<PrayerRepo>(
    () => PrayerRepoImpl(
      locationDataSrc: sl<LocationDataSrc>(),
      prayerTimesDataSrc: sl<PrayerTimesDataSrc>(),
    ),
  );
  // data src
  sl.registerLazySingleton<LocationDataSrc>(() => LocationDataSrcImpl());
  sl.registerLazySingleton<PrayerTimesDataSrc>(() => PrayerTimesDataSrcImpl());

  // Saved Ayah Cubit //////////////////////////////////////////////////////////
  // bloc
  sl.registerFactory<SavedAyahCubit>(
    () => SavedAyahCubit(
      saveVerseUsecase: sl(),
      getSavedVerseUsecase: sl(),
      removeVerseUsecase: sl(),
    ),
  );
  // usecases
  sl.registerLazySingleton<SaveVerseUsecase>(
    () => SaveVerseUsecase(savedRepo: sl<SavedRepo>()),
  );
  sl.registerLazySingleton<GetSavedVerseUsecase>(
    () => GetSavedVerseUsecase(savedRepo: sl<SavedRepo>()),
  );
  sl.registerLazySingleton<RemoveVerseUsecase>(
    () => RemoveVerseUsecase(savedRepo: sl<SavedRepo>()),
  );
  // repositories
  sl.registerLazySingleton<SavedRepo>(
    () => SavedRepoImpl(savedDataSource: sl()),
  );
  // data source
  sl.registerLazySingleton<SavedDataSource>(
    () => SavedDataSourceImpl(boxVerse: sl(), boxHadith: sl(), boxSurah: sl()),
  );
  // boxs
  Box<SavedAyahModel> ayahsBox = await Hive.openBox<SavedAyahModel>('ayahs');
  sl.registerLazySingleton<Box<SavedAyahModel>>(() => ayahsBox);

  Box<SavedHadithModel> hadithsBox = await Hive.openBox<SavedHadithModel>(
    'hadiths',
  );
  sl.registerLazySingleton<Box<SavedHadithModel>>(() => hadithsBox);

  Box<SavedSurahModel> suwarsBox = await Hive.openBox<SavedSurahModel>(
    'surahs',
  );
  sl.registerLazySingleton<Box<SavedSurahModel>>(() => suwarsBox);

  // SavedHadith cubit ////////////////////////////////////////////////////////
  sl.registerFactory<SavedHadithCubit>(
    () => SavedHadithCubit(
      saveHadithUsecase: sl<SaveHadithUsecase>(),
      getSavedHadithUsecase: sl<GetSavedHadithUsecase>(),
      removeHadithUsecase: sl<RemoveHadithUsecase>(),
    ),
  );
  // usecases
  sl.registerLazySingleton<SaveHadithUsecase>(
    () => SaveHadithUsecase(savedRepo: sl<SavedRepo>()),
  );
  sl.registerLazySingleton<GetSavedHadithUsecase>(
    () => GetSavedHadithUsecase(savedRepo: sl<SavedRepo>()),
  );
  sl.registerLazySingleton<RemoveHadithUsecase>(
    () => RemoveHadithUsecase(savedRepo: sl<SavedRepo>()),
  );

  // Hadith cubit /////////////////////////////////////////////////////////////
  sl.registerFactory<HadithCubit>(
    () => HadithCubit(getAllHadithsUsecase: sl<GetAllHadithsUsecase>()),
  );
  // usecases
  sl.registerLazySingleton<GetAllHadithsUsecase>(
    () => GetAllHadithsUsecase(hadithRepo: sl<HadithRepo>()),
  );

  // Chapter cubit /////////////////////////////////////////////////////////////
  sl.registerFactory<ChapterCubit>(
    () => ChapterCubit(getAllChaptersUsecase: sl<GetAllChaptersUsecase>()),
  );
  // usecases
  sl.registerLazySingleton<GetAllChaptersUsecase>(
    () => GetAllChaptersUsecase(hadithRepo: sl<HadithRepo>()),
  );

  // Book cubit ////////////////////////////////////////////////////////////////
  sl.registerFactory<BookCubit>(
    () => BookCubit(getAllBooksUsecase: sl<GetAllBooksUsecase>()),
  );
  // usecases
  sl.registerLazySingleton<GetAllBooksUsecase>(
    () => GetAllBooksUsecase(hadithRepo: sl<HadithRepo>()),
  );
  // repositories
  sl.registerLazySingleton<HadithRepo>(
    () => HadithRepoImpl(remoteDataSource: sl<HadithRemoteDataSource>()),
  );
  // data source
  sl.registerLazySingleton<HadithRemoteDataSource>(
    () => HadithRemoteDataSourceImpl(apiConsumer: sl<ApiConsumer>()),
  );

  // Taffsir cubit /////////////////////////////////////////////////////////////
  sl.registerFactory<TaffsirCubit>(
    () => TaffsirCubit(taffsirRepo: sl<TaffsirRepo>()),
  );
  // repositories
  sl.registerLazySingleton<TaffsirRepo>(
    () => TaffsirRepo(taffsirService: sl<GetTaffsirOfQuranService>()),
  );
  // services
  sl.registerLazySingleton<GetTaffsirOfQuranService>(
    () => GetTaffsirOfQuranService(api: sl<ApiConsumer>()),
  );

  // Audio cubit ///////////////////////////////////////////////////////////////
  sl.registerFactory<AudioCubit>(() => AudioCubit());

  // Listen Cubit //////////////////////////////////////////////////////////////
  // bloc
  sl.registerFactory<ListenCubit>(
    () => ListenCubit(quranAudioRepository: sl<QuranAudioRepository>()),
  );
  // repositories
  sl.registerLazySingleton<QuranAudioRepository>(
    () => QuranAudioRepository(quraneAudioService: sl<QuraneAudioService>()),
  );
  // services
  sl.registerLazySingleton<QuraneAudioService>(
    () => QuraneAudioService(api: sl<ApiConsumer>()),
  );

  // Home Cubit ////////////////////////////////////////////////////////////////
  // bloc
  sl.registerFactory<HomeCubit>(() => HomeCubit(quranRepo: sl<QuranRepoo>()));
  // repositories
  sl.registerLazySingleton<QuranRepoo>(
    () => QuranRepoo(quraneService: sl<QuraneService>()),
  );
  // services
  sl.registerLazySingleton<QuraneService>(
    () => QuraneService(api: sl<ApiConsumer>()),
  );
  // api consumer
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl<Dio>()));
  // dio
  final Dio dio = Dio();
  sl.registerLazySingleton<Dio>(
    () => dio,
  );

  //// Core
  // Network cubit /////////////////////////////////////////////////////////////
  // bloc
  sl.registerFactory<NetWorkCubit>(
    () => NetWorkCubit(
      getConnectionStatusUsecase: sl<GetConnectionStatusUsecase>(),
      listenToConnectionStatus: sl<ListenToConnectionStatus>(),
    ),
  );
  // usecases
  sl.registerLazySingleton<GetConnectionStatusUsecase>(
    () => GetConnectionStatusUsecase(connectionRepo: sl<ConnectionRepo>()),
  );
  sl.registerLazySingleton<ListenToConnectionStatus>(
    () => ListenToConnectionStatus(connectionRepo: sl<ConnectionRepo>()),
  );
  // repositories
  sl.registerLazySingleton<ConnectionRepo>(
    () => ConnectionRepoImpl(connection: sl<InternetConnection>()),
  );
  // intrnet connection
  sl.registerLazySingleton<InternetConnection>(() => InternetConnection());
}
