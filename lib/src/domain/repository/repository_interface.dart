import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class RepositoryInterface {
  void showSnack(
      {required BuildContext context,
      required String textMessage,
      required typeSnack});

  Future<void> savePrefs(
      {required dynamic type, required String key, required dynamic value});
  Future<dynamic> loadPrefs({required dynamic type, required String key});

  Future<List<dynamic>> registerFirebaseWithEmail(
      {required String email,
      required String password,
      required String username});

  Future<List<dynamic>> loginUserForEmail(
      {required String email, required String password});

  Future<List<dynamic>> changePasswordFirebase({required String email});

  Future<List<dynamic>> getDataGoogle();
  Future<List<dynamic>> loginFirebaseWithGoogle(
      {required OAuthCredential credential, required String email});

  Future<List<dynamic>> registerFirebaseWithGoogle(
      {required OAuthCredential credential,
      required String email,
      required String username});

  Future<List<dynamic>> checkUserForEmail({required String email});

  Future<List<dynamic>> createNewUser(
      {required String email,
      required String username,
      required String idFirebase});

  Future<List<dynamic>> createNewShop(
      {required String nameShop, required String idUser});
}
