import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sakina/app_localizations.dart';
import 'package:sakina/core/apis/dio_consumer.dart';
import 'package:sakina/core/cubits/InternetCubit/internet_cubit.dart';
import 'package:sakina/core/constants/colors.dart';
import 'package:sakina/core/services/quran_services/qurane_service.dart';
import 'package:sakina/features/home/cubit/AudioCubit/audio_cubit.dart';
import 'package:sakina/features/home/pages/bottom_bar_page.dart';
import 'package:sakina/features/home/cubit/HomeCubit/home_cubit.dart';
import 'package:sakina/features/home/repositories/quran_repository.dart';
import 'package:sakina/splash.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

late final AudioHandler audioHandler;

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
          create: (context) => HomeCubit(
            quranRepo: QuranRepository(
              quraneService: QuraneService(api: DioConsumer(dio: dio)),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => AudioCubit(),
        ),
        BlocProvider(
          create: (context) => InternetCubit(),
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
          colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        ),
        routes: {
          '/': (context) => Spalsh(),
          BottomBarPage.pageRoute: (context) => BottomBarPage(),
        },
      ),
    );
  }
}
