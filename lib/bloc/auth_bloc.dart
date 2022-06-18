import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_video_stream/screens/widgets/custom_widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/app_constants.dart';
import '../core/routes.dart';
import '../model/user_model.dart';

class AuthBloc {
  Future<void> setUserToken(UserModel model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString(AppConstants.TOKEN, model.auth.accessToken);
    AppConstants.loggedUser = model;
    preferences.setString(
        AppConstants.USERMODEL_STRING, userModelToJson(model));
  }

  void logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.remove(AppConstants.USERMODEL_STRING);
    AppConstants.loggedUser = null;
    AppConstants.navigatorKey.currentState
        .pushNamedAndRemoveUntil(Routes.login, (route) => false);
  }

  Future<void> login(UserModel response, BuildContext context) async {
    try {
      await setUserToken(response);
      AppConstants.navigatorKey.currentState
          .pushNamedAndRemoveUntil(Routes.dashboard, (route) => false);
    } catch (e) {
      CustomWidgets.showSnackbar(e.toString(), context);
    }
  }

  dispose() {}

  Future<bool> checkTokenExists() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    try {
      // return preferences.containsKey(AppConstants.TOKEN);
      if (preferences.containsKey(AppConstants.USERMODEL_STRING)) {
        AppConstants.loggedUser = userModelFromJson(
            preferences.getString(AppConstants.USERMODEL_STRING));
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
