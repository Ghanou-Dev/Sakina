import 'package:audio_session/audio_session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sakina/app_localizations.dart';
import 'package:sakina/core/apis/dio_consumer.dart';
import 'package:sakina/core/connection/data/repositories/connection_repo_impl.dart';
import 'package:sakina/core/connection/domain/usecases/get_connection_status_usecase.dart';
import 'package:sakina/core/connection/domain/usecases/listen_to_connection_status.dart';
import 'package:sakina/core/connection/presentation/cubit/network_cubit.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/my_bloc_observer.dart';
import 'package:sakina/core/services/quran_services/qurane_audio_service.dart';
import 'package:sakina/core/services/quran_services/qurane_service.dart';
import 'package:sakina/features/hadith/data/data_sources/hadith_remote_data_source.dart';
import 'package:sakina/features/hadith/data/repositories/hadith_repo_impl.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_books_usecase.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_chapters_usecase.dart';
import 'package:sakina/features/hadith/domain/usecases/get_all_hadiths_usecase.dart';
import 'package:sakina/features/hadith/presentation/cubits/book_cubit/book_cubit.dart';
import 'package:sakina/features/hadith/presentation/cubits/chapter_cubit/chapter_cubit.dart';
import 'package:sakina/features/hadith/presentation/cubits/hadith_cubit/hadith_cubit.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/ListenCubit/listen_cubit.dart';
import 'package:sakina/features/home/cubit/TaffsirCubit/taffsir_cubit.dart';
import 'package:sakina/features/home/pages/bottom_bar_page.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/repositories/quran_audio_repository.dart';
import 'package:sakina/features/home/repositories/quran_repoo.dart';
import 'package:sakina/features/home/repositories/taffsir_repo.dart';
import 'package:sakina/features/home/services/get_taffsir_of_qurane_service.dart';
import 'package:sakina/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'Sakina.player.01',
    androidNotificationChannelName: 'Sakina',
    notificationColor: Colors.deepPurple.shade300,
    androidNotificationOngoing: true,
  );

  final session = await AudioSession.instance;
  await session.configure(
    AudioSessionConfiguration.music(),
  );

  final Dio d = Dio();
  Bloc.observer = MyBlocObserver();
  runApp(
    Sakina(
      dio: d,
    ),
  );
}

class Sakina extends StatelessWidget {
  final Dio dio;
  const Sakina({super.key, required this.dio});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NetWorkCubit(
            getConnectionStatusUsecase: GetConnectionStatusUsecase(
              connectionRepo: ConnectionRepoImpl(
                connection: InternetConnection(),
              ),
            ),
            listenToConnectionStatus: ListenToConnectionStatus(
              connectionRepo: ConnectionRepoImpl(
                connection: InternetConnection(),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => HomeCubit(
            quranRepo: QuranRepoo(
              quraneService: QuraneService(api: DioConsumer(dio: dio)),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ListenCubit(
            quranAudioRepository: QuranAudioRepository(
              quraneAudioService: QuraneAudioService(
                api: DioConsumer(dio: dio),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AudioCubit(),
        ),
        BlocProvider(
          create: (context) => TaffsirCubit(
            taffsirRepo: TaffsirRepo(
              taffsirService: GetTaffsirOfQuranService(
                api: DioConsumer(dio: dio),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => BookCubit(
            getAllBooksUsecase: GetAllBooksUsecase(
              hadithRepo: HadithRepoImpl(
                remoteDataSource: HadithRemoteDataSourceImpl(
                  apiConsumer: DioConsumer(dio: dio),
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ChapterCubit(
            getAllChaptersUsecase: GetAllChaptersUsecase(
              hadithRepo: HadithRepoImpl(
                remoteDataSource: HadithRemoteDataSourceImpl(
                  apiConsumer: DioConsumer(dio: dio),
                ),
              ),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => HadithCubit(
            getAllHadithsUsecase: GetAllHadithsUsecase(
              hadithRepo: HadithRepoImpl(
                remoteDataSource: HadithRemoteDataSourceImpl(
                  apiConsumer: DioConsumer(dio: dio),
                ),
              ),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        supportedLocales: [
          Locale('en'),
          Locale('ar'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          final languagesCodeSupportedLocales = supportedLocales
              .map((local) => local.languageCode)
              .toList();
          bool isDeviceLandSupported = languagesCodeSupportedLocales.contains(
            locale!.languageCode,
          );
          if (isDeviceLandSupported) {
            return locale;
          } else {
            return supportedLocales.first;
          }
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        ),
        routes: {
          '/': (context) => Spalsh(),
          BottomBarPage.pageRoute: (context) => BottomBarPage(),
        },
      ),
    );
  }
}
