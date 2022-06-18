import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_video_stream/model/video_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_constants.dart';
import '../model/user_model.dart';

class CoreBloc {
  Future<bool> initSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    try {
      if (sharedPreferences.containsKey(AppConstants.USERMODEL_STRING)) {
        AppConstants.loggedUser = userModelFromJson(
            sharedPreferences.getString(AppConstants.USERMODEL_STRING));
      }
      if (sharedPreferences
          .containsKey(AppConstants.avialbleVideosListString)) {
        AppConstants.availableVideos = videomodelFromJson(
            sharedPreferences.getString(AppConstants.avialbleVideosListString));
      } else {
        // declare videos

        AppConstants.availableVideos = [
          Videomodel(
              id: 1,
              isDownloaded: false,
              localPathDirectory: null,
              url:
                  'https://drive.google.com/u/2/uc?id=1z-xRG-llBx1FszFwWY0ql9bAVyc9fSDe',
              title: 'earth'),
          Videomodel(
              id: 2,
              isDownloaded: false,
              localPathDirectory: null,
              url:
                  'https://drive.google.com/u/2/uc?id=1SlqiA7ls01VjIikhDWtE4JsxhKcJz5wf',
              title: 'butterfly'),
          Videomodel(
              id: 3,
              isDownloaded: false,
              localPathDirectory: null,
              url:
                  'https://drive.google.com/u/2/uc?id=1nMkJGFwxS3zIsX4VfdJrt8kq4UMRtCE3',
              title: 'dandelion'),
        ];
        sharedPreferences.setString(AppConstants.avialbleVideosListString,
            videomodelToJson(AppConstants.availableVideos));
      }
    } catch (e) {
      print(e.toString());
    }
    return Future.value(true);
  }

  Future<bool> removeSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  dispose() {}
}
