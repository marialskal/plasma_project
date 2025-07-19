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
    apiKey: 'AIzaSyAu_bsxOZAGpsscwmMDasTcLc05ZIvGKdg',
    authDomain: 'chat-app-3f9f8.firebaseapp.com',
    projectId: 'chat-app-3f9f8',
    storageBucket: 'chat-app-3f9f8.firebasestorage.app',
    messagingSenderId: '240429644157',
    appId: '1:240429644157:web:c3002772b0a3da4d18f414',
    measurementId: 'G-Y45M912DX1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvkuYFUaL-Sif6cXqWoBeTuBYlC1uoc9o',
    appId: '1:240429644157:android:9bf50c95b3576b1a18f414',
    messagingSenderId: '240429644157',
    projectId: 'chat-app-3f9f8',
    storageBucket: 'chat-app-3f9f8.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBScM32P8NsQ56CEoxBz57-o-wp83M8eTs',
    appId: '1:240429644157:ios:f4d70876f96f882918f414',
    messagingSenderId: '240429644157',
    projectId: 'chat-app-3f9f8',
    storageBucket: 'chat-app-3f9f8.firebasestorage.app',
    iosBundleId: 'com.example.scholarChat',
  );
}