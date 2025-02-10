import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: 'AIzaSyAUUMNT2409Rq3yR9RoGFOX9_FFTGT-CEM',
        authDomain: '',
        projectId: 'auth-778dc',
        storageBucket: 'e-commerce-9687.firebasestorage.app',
        messagingSenderId: 'your-sender-id',
        appId: '1:420697396088:android:91bc5102ad215c5038ee8d',
        measurementId: 'your-measurement-id',
        databaseURL: "https://e-commerce-9687-default-rtdb.firebaseio.com/",
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      // Firebase configuration for Android
      return const FirebaseOptions(
        apiKey: 'AIzaSyAUUMNT2409Rq3yR9RoGFOX9_FFTGT-CEM',
        authDomain: '',
        projectId: 'auth-778dc',
        storageBucket: 'e-commerce-9687.firebasestorage.app',
        messagingSenderId: 'your-sender-id',
        appId: '1:420697396088:android:91bc5102ad215c5038ee8d',
        measurementId: 'your-measurement-id',
        databaseURL: "https://e-commerce-9687-default-rtdb.firebaseio.com/",
      );
    }
    // Add configurations for other platforms (iOS, Android) if needed
    throw UnsupportedError('Unsupported platform');
  }
}
