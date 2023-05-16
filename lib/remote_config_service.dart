import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class FirebaseRemoteConfigService {
  const FirebaseRemoteConfigService();

  Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    final FirebaseRemoteConfig firebaseRemoteConfig = FirebaseRemoteConfig.instance;

    try {
      await firebaseRemoteConfig.ensureInitialized();
      await firebaseRemoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 120),
          minimumFetchInterval: const Duration(seconds: 10),
        ),
      );
      await firebaseRemoteConfig.fetchAndActivate();
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print('Unable to initialize Firebase Remote Config $e');
      }
    }
    return firebaseRemoteConfig;
  }
}
