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
    apiKey: 'AIzaSyDemoKeyForMentalHealthApp',
    appId: '1:123456789:web:mentalhealthdemo',
    messagingSenderId: '123456789',
    projectId: 'mental-health-support-demo',
    authDomain: 'mental-health-support-demo.firebaseapp.com',
    storageBucket: 'mental-health-support-demo.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForMentalHealthApp',
    appId: '1:123456789:android:mentalhealthdemo',
    messagingSenderId: '123456789',
    projectId: 'mental-health-support-demo',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForMentalHealthApp',
    appId: '1:123456789:ios:mentalhealthdemo',
    messagingSenderId: '123456789',
    projectId: 'mental-health-support-demo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForMentalHealthApp',
    appId: '1:123456789:ios:mentalhealthdemo',
    messagingSenderId: '123456789',
    projectId: 'mental-health-support-demo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDemoKeyForMentalHealthApp',
    appId: '1:123456789:web:mentalhealthdemo',
    messagingSenderId: '123456789',
    projectId: 'mental-health-support-demo',
  );
}