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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyDLwvyBqYqBmIsrJAk3AlVLDXChXveHURY',
    appId: '1:1028296314170:web:3f548b40f9d66e08ff1403',
    messagingSenderId: '1028296314170',
    projectId: 'apk-tugas-kuliah-4d776',
    authDomain: 'apk-tugas-kuliah-4d776.firebaseapp.com',
    storageBucket: 'apk-tugas-kuliah-4d776.firebasestorage.app',
    measurementId: 'G-7R8K071KCH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAE_KAFRTq-PZXkDRUIWJYYM0DztIiy3xs',
    appId: '1:1028296314170:android:792db83ebb0b61c9ff1403',
    messagingSenderId: '1028296314170',
    projectId: 'apk-tugas-kuliah-4d776',
    storageBucket: 'apk-tugas-kuliah-4d776.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdB_K2hyoj8tR8iiF4BOWCY6p2jXJPSGQ',
    appId: '1:1028296314170:ios:084939dc7d43d84aff1403',
    messagingSenderId: '1028296314170',
    projectId: 'apk-tugas-kuliah-4d776',
    storageBucket: 'apk-tugas-kuliah-4d776.firebasestorage.app',
    iosBundleId: 'com.example.apkTugas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAdB_K2hyoj8tR8iiF4BOWCY6p2jXJPSGQ',
    appId: '1:1028296314170:ios:084939dc7d43d84aff1403',
    messagingSenderId: '1028296314170',
    projectId: 'apk-tugas-kuliah-4d776',
    storageBucket: 'apk-tugas-kuliah-4d776.firebasestorage.app',
    iosBundleId: 'com.example.apkTugas',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDLwvyBqYqBmIsrJAk3AlVLDXChXveHURY',
    appId: '1:1028296314170:web:03cf9e12f692755eff1403',
    messagingSenderId: '1028296314170',
    projectId: 'apk-tugas-kuliah-4d776',
    authDomain: 'apk-tugas-kuliah-4d776.firebaseapp.com',
    storageBucket: 'apk-tugas-kuliah-4d776.firebasestorage.app',
    measurementId: 'G-73SX17G7MC',
  );
}
