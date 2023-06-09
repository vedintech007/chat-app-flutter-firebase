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
    apiKey: 'AIzaSyDA7PebuLQHEaOil_HebfscVqlKIB1bRSI',
    appId: '1:1086932682925:web:9b0c981d5ef81aab5a9e24',
    messagingSenderId: '1086932682925',
    projectId: 'ved-group-chat',
    authDomain: 'ved-group-chat.firebaseapp.com',
    storageBucket: 'ved-group-chat.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBP0ZZRNPXcuwvVMYjb4AG9qu3lY4EYqug',
    appId: '1:1086932682925:android:3266915f67693c8c5a9e24',
    messagingSenderId: '1086932682925',
    projectId: 'ved-group-chat',
    storageBucket: 'ved-group-chat.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBLTRFvPjTTpTeI6ThvuGWTelb-eY_8B24',
    appId: '1:1086932682925:ios:111a8e8fceb60b115a9e24',
    messagingSenderId: '1086932682925',
    projectId: 'ved-group-chat',
    storageBucket: 'ved-group-chat.appspot.com',
    iosClientId: '1086932682925-qvirkf38fo2lsb10rmp21a0lgov5683m.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterChatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBLTRFvPjTTpTeI6ThvuGWTelb-eY_8B24',
    appId: '1:1086932682925:ios:111a8e8fceb60b115a9e24',
    messagingSenderId: '1086932682925',
    projectId: 'ved-group-chat',
    storageBucket: 'ved-group-chat.appspot.com',
    iosClientId: '1086932682925-qvirkf38fo2lsb10rmp21a0lgov5683m.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterChatApp',
  );
}
