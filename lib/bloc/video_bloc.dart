import 'dart:async';
import 'dart:io';

import 'package:flutter_video_stream/core/app_constants.dart';
import 'package:flutter_video_stream/helper/encryption.dart';
import 'package:flutter_video_stream/repository/video_repository.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/video_model.dart';

class VideoBloc {
  final VideoRepository _repository = VideoRepository();

  final StreamController<String> _downloadStatus =
      StreamController<String>.broadcast();

  Stream<String> get downloadStatus => _downloadStatus.stream;

  downloadFile(String url, String filename) async {
    try {
      _downloadStatus.sink.add("");
      await Permission.storage.request();
      await Permission.accessMediaLocation.request();
      await Permission.manageExternalStorage.request();

      if (await Permission.storage.isGranted) {
        Directory appDocDir = await getExternalStorageDirectory();

        await _repository.downloadFile(url, '${appDocDir.path}/$filename',
            (String text) {
          _downloadStatus.sink.add(text);
        });
        _downloadStatus.sink.add("Encrypting file...");
        return EncryptData.encryptfile('${appDocDir.path}/$filename');
      } else {
        _downloadStatus.sink.addError("File access permission denied");
      }
    } catch (e) {
      _downloadStatus.sink.addError(e.toString());
      return null;
    }
  }

  updateVideoLibrary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(AppConstants.avialbleVideosListString,
        videomodelToJson(AppConstants.availableVideos));
  }
}
