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
    apiKey: 'AIzaSyBigXOi8P5nCAET8x2hDhW6rjRVM-jfd7g',
    appId: '1:412350863027:web:2cd31503af82b2bfbec2c6',
    messagingSenderId: '412350863027',
    projectId: 'auth2-a4c3e',
    authDomain: 'auth2-a4c3e.firebaseapp.com',
    storageBucket: 'auth2-a4c3e.appspot.com',
    measurementId: 'G-MZHN7CSBY0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBxBokkw9yfrT9bz3IQkZmOfcf8weJFxXU',
    appId: '1:412350863027:android:5a93e6127286bb24bec2c6',
    messagingSenderId: '412350863027',
    projectId: 'auth2-a4c3e',
    storageBucket: 'auth2-a4c3e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBk_kFb-HHYk6xT9-JFUBdIhiWBZcjKII8',
    appId: '1:412350863027:ios:9533ee09e08ebad4bec2c6',
    messagingSenderId: '412350863027',
    projectId: 'auth2-a4c3e',
    storageBucket: 'auth2-a4c3e.appspot.com',
    androidClientId: '412350863027-dfithg8h0668v1h52h9hsqf9602k1r40.apps.googleusercontent.com',
    iosClientId: '412350863027-65gdcskg21hjetn81i6avfsbelrob5jl.apps.googleusercontent.com',
    iosBundleId: 'com.example.auth2',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBk_kFb-HHYk6xT9-JFUBdIhiWBZcjKII8',
    appId: '1:412350863027:ios:7fb93331193a4940bec2c6',
    messagingSenderId: '412350863027',
    projectId: 'auth2-a4c3e',
    storageBucket: 'auth2-a4c3e.appspot.com',
    androidClientId: '412350863027-dfithg8h0668v1h52h9hsqf9602k1r40.apps.googleusercontent.com',
    iosClientId: '412350863027-kkkht634utqqick2guhihvfisk20krgs.apps.googleusercontent.com',
    iosBundleId: 'com.example.auth2.RunnerTests',
  );
}
