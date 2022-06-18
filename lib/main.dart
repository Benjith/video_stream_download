import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_video_stream/screens/settings/settings_list_screen.dart';
import 'package:flutter_video_stream/screens/widgets/custom_widgets.dart';
import 'bloc/auth_bloc.dart';
import 'bloc/core_bloc.dart';
import 'core/app_constants.dart';
import 'core/routes.dart';
import 'firebase_options.dart';
import 'screens/auth/login_screen.dart';

import 'screens/user/profile_screen.dart';
import 'screens/video/avilable_videos_list_screen.dart';
import 'screens/video/video_player_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CoreBloc().initSharedData();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  void changeTheme() {
    setState(() {
      AppConstants.isDarkMode = !AppConstants.isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      title: AppConstants.APP_NAME,
      initialRoute: Routes.splash,
      navigatorKey: AppConstants.navigatorKey,
      theme: AppConstants.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.dashboard:
            return MaterialPageRoute(
                builder: (context) => const VideoPlayerScreen());
            break;
          case Routes.login:
            return MaterialPageRoute(builder: (context) => const LoginScreen());
            break;
          case Routes.splash:
            return MaterialPageRoute(
                builder: (context) => const SplashScreen());
            break;
          case Routes.profile:
            return MaterialPageRoute(
                builder: (context) => const ProfileScreen());
            break;
          case Routes.settings:
            return MaterialPageRoute(
                builder: (context) => const SettingsListScreen());
            break;
          default:
            return null;
        }
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthBloc _authBloc = AuthBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 2), () async {
        if (await _authBloc.checkTokenExists()) {
          AppConstants.navigatorKey.currentState
              .pushReplacementNamed(Routes.dashboard);
        } else {
          AppConstants.navigatorKey.currentState
              .pushReplacementNamed(Routes.login);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(),
            child: const Center(
              child: Hero(
                  tag: 'logo',
                  child: FlutterLogo(
                    size: 200,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CustomWidgets.stoppedAnimationProgress(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
