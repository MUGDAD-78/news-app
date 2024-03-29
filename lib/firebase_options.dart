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
    apiKey: 'AIzaSyCw6j3-nqW2-svW25rsowc_31V-E0xTS9s',
    appId: '1:748063337249:web:552705e8655dd59a77ec60',
    messagingSenderId: '748063337249',
    projectId: 'news-app-52020',
    authDomain: 'news-app-52020.firebaseapp.com',
    storageBucket: 'news-app-52020.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBiMCkjCQkYlCsIFd3t1oFy_xqWPDk7XnI',
    appId: '1:748063337249:android:531d783986881d7277ec60',
    messagingSenderId: '748063337249',
    projectId: 'news-app-52020',
    storageBucket: 'news-app-52020.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCd9mxv41OmmTxWc8x7dUmnkwJrT7lzuRE',
    appId: '1:748063337249:ios:e60f1c2265f8ac1777ec60',
    messagingSenderId: '748063337249',
    projectId: 'news-app-52020',
    storageBucket: 'news-app-52020.appspot.com',
    iosBundleId: 'com.example.newsApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCd9mxv41OmmTxWc8x7dUmnkwJrT7lzuRE',
    appId: '1:748063337249:ios:ed8d5cc2018ac6e377ec60',
    messagingSenderId: '748063337249',
    projectId: 'news-app-52020',
    storageBucket: 'news-app-52020.appspot.com',
    iosBundleId: 'com.example.newsApp.RunnerTests',
  );
}
