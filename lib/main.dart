import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:sakina/helpers/constants/colors.dart';
import 'package:sakina/pages/bottom_bar_page.dart';
import 'package:sakina/cubits/AudioCubit/audio_cubit.dart';
import 'package:sakina/cubits/HomeCubit/home_cubit.dart';
import 'package:sakina/pages/splash.dart';
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
  runApp(Sakina());
}

class Sakina extends StatelessWidget {
  const Sakina({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeCubit(),
        ),
        BlocProvider(
          create: (context) => AudioCubit(),
        ),
      ],
      child: MaterialApp(
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
