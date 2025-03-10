// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDj3JvFzDaj0TH4e9qKjlY72rlXjYfBQYc',
    appId: '1:537422570125:web:3b8c1793d498ec93a578c4',
    messagingSenderId: '537422570125',
    projectId: 'assigment-29044',
    authDomain: 'assigment-29044.firebaseapp.com',
    storageBucket: 'assigment-29044.firebasestorage.app',
    measurementId: 'G-FGF1KB9WY8',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC5IH61J8bz0ib7IN3fvE2BiyZtnyIMgk',
    appId: '1:537422570125:android:b8e2ece4b9e28449a578c4',
    messagingSenderId: '537422570125',
    projectId: 'assigment-29044',
    storageBucket: 'assigment-29044.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4IBg5lGfACTOAHIOtp4ptWGK29aoVmRM',
    appId: '1:537422570125:ios:8f48824c69354e26a578c4',
    messagingSenderId: '537422570125',
    projectId: 'assigment-29044',
    storageBucket: 'assigment-29044.firebasestorage.app',
    iosBundleId: 'com.example.assigment',
  );

}