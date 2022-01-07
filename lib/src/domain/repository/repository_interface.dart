import 'package:firebase_auth/firebase_auth.dart';

abstract class RepositoryInterface {
  Future<void> savePrefs(
      {required dynamic type, required String key, required dynamic value});
  Future<dynamic> loadPrefs({required dynamic type, required String key});
  Future register();
  Future login();
  Future<List<dynamic>> registerFirebaseWithEmail(
      {required String email, required String password});

  Future<List<dynamic>> loginUserForEmail(
      {required String email, required String password});

  Future<List<dynamic>> changePasswordFirebase({required String email});

  Future<List<dynamic>> getDataGoogle();
  Future<List<dynamic>> loginFirebaseWithGoogle(
      {required OAuthCredential credential});
  Future<List<dynamic>> getUserForEmail({required String email});
}
