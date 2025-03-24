import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ParentalControlService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(hours: 1),
    ));
    await _remoteConfig.fetchAndActivate();
  }

  Future<bool> isParentalControlEnabled() async {
    return _remoteConfig.getBool('enable_parental_control');
  }

  Future<bool> authenticateAdmin(String secretCode) async {
    final doc = await _firestore.collection('admin_settings').doc('master').get();
    return doc.data()?['secret_code'] == secretCode;
  }

  Future<List<String>> getRestrictedKeywords() async {
    final snapshot = await _firestore.collection('content_filters').doc('islamic').get();
    return List<String>.from(snapshot.data()?['keywords'] ?? []);
  }
}