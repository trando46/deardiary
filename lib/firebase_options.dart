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
    apiKey: 'AIzaSyCt3_rLgXqGbVTUdPmsR8z6uk2pkHoWTKc',
    appId: '1:122433301228:web:e0953b49a9e0a27e3913c9',
    messagingSenderId: '122433301228',
    projectId: 'deardiaryfirebase',
    authDomain: 'deardiaryfirebase.firebaseapp.com',
    storageBucket: 'deardiaryfirebase.appspot.com',
    measurementId: 'G-4MJ77C6TRV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9A7YRLzjkSSNTejkM7ntMoU6-2dgDGTM',
    appId: '1:122433301228:android:0f73baf4ba145b143913c9',
    messagingSenderId: '122433301228',
    projectId: 'deardiaryfirebase',
    storageBucket: 'deardiaryfirebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDO50XX05sgDJi40Obaampyr6o4errEOhw',
    appId: '1:122433301228:ios:45dbbb7774390c793913c9',
    messagingSenderId: '122433301228',
    projectId: 'deardiaryfirebase',
    storageBucket: 'deardiaryfirebase.appspot.com',
    iosClientId: '122433301228-87p8vaorrmrojb6l0b9u0k4ip33eednm.apps.googleusercontent.com',
    iosBundleId: 'com.example.deardiary',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDO50XX05sgDJi40Obaampyr6o4errEOhw',
    appId: '1:122433301228:ios:45dbbb7774390c793913c9',
    messagingSenderId: '122433301228',
    projectId: 'deardiaryfirebase',
    storageBucket: 'deardiaryfirebase.appspot.com',
    iosClientId: '122433301228-87p8vaorrmrojb6l0b9u0k4ip33eednm.apps.googleusercontent.com',
    iosBundleId: 'com.example.deardiary',
  );
}
