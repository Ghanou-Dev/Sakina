import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sakina/core/services/app_localizations.dart';
import 'package:sakina/core/connection/presentation/cubit/network_cubit.dart';
import 'package:sakina/core/constants/app_colors.dart';
import 'package:sakina/core/my_bloc_observer.dart';
import 'package:sakina/features/hadith/presentation/cubits/book_cubit/book_cubit.dart';
import 'package:sakina/features/hadith/presentation/cubits/chapter_cubit/chapter_cubit.dart';
import 'package:sakina/features/hadith/presentation/cubits/hadith_cubit/hadith_cubit.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/cubit/ListenCubit/listen_cubit.dart';
import 'package:sakina/features/home/cubit/TaffsirCubit/taffsir_cubit.dart';
import 'package:sakina/features/home/pages/bottom_bar_page.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/prayer/presentation/cubits/location_cubit/location_cubit.dart';
import 'package:sakina/features/prayer/presentation/cubits/prayer_cubit/prayer_cubit.dart';
import 'package:sakina/features/saved/data/models/saved_ayah_model.dart';
import 'package:sakina/features/saved/data/models/saved_hadith_model.dart';
import 'package:sakina/features/saved/data/models/saved_surah_model.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_ayah_cubit/saved_ayah_cubit.dart';
import 'package:sakina/features/saved/presentation/cubits/saved_hadith_cubit/saved_hadith_cubit.dart';
import 'package:sakina/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/services/injection_container.dart' as di;
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  // init flutter
  WidgetsFlutterBinding.ensureInitialized();
  // init just audio background
  await JustAudioBackground.init(
    androidNotificationChannelId: 'Sakina.player.01',
    androidNotificationChannelName: 'Sakina',
    notificationColor: Colors.deepPurple.shade300,
    androidNotificationOngoing: true,
  );
  // init audio session
  final session = await AudioSession.instance;
  await session.configure(
    AudioSessionConfiguration.music(),
  );
  // init hive
  await Hive.initFlutter();
  // regester adapters
  Hive.registerAdapter<SavedAyahModel>(SavedAyahModelAdapter());
  Hive.registerAdapter<SavedHadithModel>(SavedHadithModelAdapter());
  Hive.registerAdapter<SavedSurahModel>(SavedSurahModelAdapter());
  // initialize service localtor
  await di.init();
  Bloc.observer = MyBlocObserver();
  // init timezones
  tz.initializeTimeZones();
  runApp(
    Sakina(),
  );
}

class Sakina extends StatelessWidget {
  const Sakina({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<NetWorkCubit>()),
        BlocProvider(create: (context) => di.sl<HomeCubit>()),
        BlocProvider(create: (context) => di.sl<ListenCubit>()),
        BlocProvider(create: (context) => di.sl<AudioCubit>()),
        BlocProvider(create: (context) => di.sl<TaffsirCubit>()),
        BlocProvider(create: (context) => di.sl<BookCubit>()),
        BlocProvider(create: (context) => di.sl<ChapterCubit>()),
        BlocProvider(create: (context) => di.sl<HadithCubit>()),
        BlocProvider(create: (context) => di.sl<SavedHadithCubit>()),
        BlocProvider(create: (context) => di.sl<SavedAyahCubit>()),
        BlocProvider(create: (context) => di.sl<LocationCubit>()),
        BlocProvider(create: (context) => di.sl<PrayerCubit>()),
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
