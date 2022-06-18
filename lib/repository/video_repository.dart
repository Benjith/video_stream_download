import 'dart:io';

import 'package:dio/dio.dart';

class VideoRepository {
  downloadFile(String url, String savePath, Function callBack) async {
    try {
      // var response =
      await Dio().downloadUri(Uri.parse(url), savePath, deleteOnError: true,
          onReceiveProgress: (int received, int total) {
        if (total != -1) {
          callBack("${(received / total * 100).toStringAsFixed(0)}%");
        }
      });
    } catch (e) {
      throw e.toString();
    }
  }
}
