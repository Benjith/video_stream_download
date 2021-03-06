// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA03HpBHgbgqw67PdF4iEu6igKKAJStLpA',
    appId: '1:740465734498:web:50f2701204906ae472723b',
    messagingSenderId: '740465734498',
    projectId: 'fluttervideostream',
    authDomain: 'fluttervideostream.firebaseapp.com',
    storageBucket: 'fluttervideostream.appspot.com',
    measurementId: 'G-HC1BM15VL5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8tMF_Xhny2dbLOkau2DteUdHrTK_WGRM',
    appId: '1:740465734498:android:548bcbea04d3098972723b',
    messagingSenderId: '740465734498',
    projectId: 'fluttervideostream',
    storageBucket: 'fluttervideostream.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZyiC4VB60OLf7jqrisXHWQ8fxiCKQlbA',
    appId: '1:740465734498:ios:248e09ba0019998872723b',
    messagingSenderId: '740465734498',
    projectId: 'fluttervideostream',
    storageBucket: 'fluttervideostream.appspot.com',
    iosClientId: '740465734498-orcavt9903ubskjia0eucu5n3vbuv4d7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterVideoStream',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZyiC4VB60OLf7jqrisXHWQ8fxiCKQlbA',
    appId: '1:740465734498:ios:248e09ba0019998872723b',
    messagingSenderId: '740465734498',
    projectId: 'fluttervideostream',
    storageBucket: 'fluttervideostream.appspot.com',
    iosClientId: '740465734498-orcavt9903ubskjia0eucu5n3vbuv4d7.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterVideoStream',
  );
}
