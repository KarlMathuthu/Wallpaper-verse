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
    apiKey: 'AIzaSyCj5Fe43jTqLAkj9ePsmoylqsc4F6ZUPnk',
    appId: '1:633539328194:web:8bb35acb6f9133cd12235b',
    messagingSenderId: '633539328194',
    projectId: 'wallpaper-verse',
    authDomain: 'wallpaper-verse.firebaseapp.com',
    storageBucket: 'wallpaper-verse.appspot.com',
    measurementId: 'G-XS68BZRW95',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCtYchHSJWzWHANe_ZXWF8u9LNG8tiWOLE',
    appId: '1:633539328194:android:320cecf43f0e128a12235b',
    messagingSenderId: '633539328194',
    projectId: 'wallpaper-verse',
    storageBucket: 'wallpaper-verse.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDSDWASisU7GvOjUc-Uo1f2l7lR5AuHfbs',
    appId: '1:633539328194:ios:676880e38fe02b7c12235b',
    messagingSenderId: '633539328194',
    projectId: 'wallpaper-verse',
    storageBucket: 'wallpaper-verse.appspot.com',
    iosClientId: '633539328194-krpinlu3c2e5pcaedem3fm919k99fan2.apps.googleusercontent.com',
    iosBundleId: 'com.example.wallpaperVerse',
  );
}
