import 'package:flutter/material.dart';
import 'package:flutter_video_stream/model/video_model.dart';

import '../model/user_model.dart';

class AppConstants {
  // app constants
  static const String APP_NAME = 'Video Stream APP';
  static UserModel loggedUser;
  static const String USERMODEL_STRING = 'usermodel';
  static const String avialbleVideosListString = 'avilableVideosList';
  static const String TOKEN = 'token';

  static bool isDarkMode = false;
  // naviagator key
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static List<Videomodel> availableVideos = [];
}
// https://drive.google.com/u/2/uc?id={file}&export=download
