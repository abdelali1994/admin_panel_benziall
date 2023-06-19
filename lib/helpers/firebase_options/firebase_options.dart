import 'dart:io';
import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get platformOptions {
    if (Platform.isIOS) {
      return const FirebaseOptions(
        // تكوين القيم الافتراضية لتطبيق Android
        appId: '',
        apiKey: '',
        projectId: 'benzi-all',
        messagingSenderId: '210745451706',
        iosBundleId: 'com.example.ecommerceWithAdminPanel',
      );
    } 
    else {
      // Android
      return const FirebaseOptions(
        // appId: '1:210745451706:android:37025394b564cea8334e83',
        appId: '1:210745451706:android:5f5dc12efce24b49334e83',
        // apiKey: 'AIzaSyBAPDiPofkCKbZ2w2-ny3A9Zpnh6TjOHMg',
        apiKey: 'AIzaSyBAPDiPofkCKbZ2w2-ny3A9Zpnh6TjOHMg',
        projectId: 'benzi-all',
        messagingSenderId: '210745451706',
      );
    }
  }

}
