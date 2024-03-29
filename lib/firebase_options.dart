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
    apiKey: 'AIzaSyBtGo7QqAFIffjJRRA87b7R6rAJr4VAxFw',
    appId: '1:598659886914:web:899301d5b76acedd80a2db',
    messagingSenderId: '598659886914',
    projectId: 'tasklist-b87c1',
    authDomain: 'tasklist-b87c1.firebaseapp.com',
    storageBucket: 'tasklist-b87c1.appspot.com',
    measurementId: 'G-ZLZX0VN0BB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDso1AYxR4KLCxRytIeiNrsxZQYVVjmtso',
    appId: '1:598659886914:android:79d1032b2602516c80a2db',
    messagingSenderId: '598659886914',
    projectId: 'tasklist-b87c1',
    storageBucket: 'tasklist-b87c1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBx9MhsRMDjmgY45MNzq25JwYZLwbiUipM',
    appId: '1:598659886914:ios:45b911be8dd1e60880a2db',
    messagingSenderId: '598659886914',
    projectId: 'tasklist-b87c1',
    storageBucket: 'tasklist-b87c1.appspot.com',
    iosBundleId: 'com.example.first',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBx9MhsRMDjmgY45MNzq25JwYZLwbiUipM',
    appId: '1:598659886914:ios:d5f9cbddd6356ec480a2db',
    messagingSenderId: '598659886914',
    projectId: 'tasklist-b87c1',
    storageBucket: 'tasklist-b87c1.appspot.com',
    iosBundleId: 'com.example.first.RunnerTests',
  );
}
