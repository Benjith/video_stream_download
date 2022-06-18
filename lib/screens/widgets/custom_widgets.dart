import 'package:flutter/material.dart';
import 'package:flutter_video_stream/core/app_constants.dart';

class CustomWidgets {
  static Widget errorReload(String message, {Function callback}) {
    return Center(
        child: InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: callback,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.refresh),
          Text(
            message ?? "",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ));
  }

  static Widget stoppedAnimationProgress({color}) => CircularProgressIndicator(
        strokeWidth: 2.5,
        valueColor:
            AlwaysStoppedAnimation<Color>(color == null ? Colors.white : color),
      );

  static Widget submitButton(String title, {Function onTap}) {
    return GestureDetector(
      // key: Key('login'),
      onTap: onTap,
      child: Container(
        height: 41,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.red),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  static showSnackbar(String s, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        s,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ));
  }
}
