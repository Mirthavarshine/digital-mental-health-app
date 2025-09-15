import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCvCgJ_6zIO26m0tpbNAsoNWjing7ohWm0',
    appId: '1:764795321038:web:635f07a08236cb9452ae9f',
    messagingSenderId: '764795321038',
    projectId: 'digitalmentalhealthapp',
    authDomain: 'digitalmentalhealthapp.firebaseapp.com',
    storageBucket: 'digitalmentalhealthapp.firebasestorage.app',
    measurementId: 'G-GE4P0CE9DQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvCgJ_6zIO26m0tpbNAsoNWjing7ohWm0',
    appId: '1:764795321038:android:635f07a08236cb9452ae9f',
    messagingSenderId: '764795321038',
    projectId: 'digitalmentalhealthapp',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCvCgJ_6zIO26m0tpbNAsoNWjing7ohWm0',
    appId: '1:764795321038:ios:635f07a08236cb9452ae9f',
    messagingSenderId: '764795321038',
    projectId: 'digitalmentalhealthapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCvCgJ_6zIO26m0tpbNAsoNWjing7ohWm0',
    appId: '1:764795321038:ios:635f07a08236cb9452ae9f',
    messagingSenderId: '764795321038',
    projectId: 'digitalmentalhealthapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCvCgJ_6zIO26m0tpbNAsoNWjing7ohWm0',
    appId: '1:764795321038:web:635f07a08236cb9452ae9f',
    messagingSenderId: '764795321038',
    projectId: 'digitalmentalhealthapp',
  );
}