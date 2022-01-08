import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:stock_stock/src/data/repository/local/translate_errors_firebase.dart';
import 'package:stock_stock/src/data/repository/remote/user/user.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class RepositoryImplementation implements RepositoryInterface {
  @override
  void showSnack(
      {required BuildContext context,
      required String textMessage,
      required typeSnack}) {
    Color color = Theme.of(context).colorScheme.primary;

    if (typeSnack == 'error') {
      color = Colors.red.shade300;
    }

    final snackBar = SnackBar(
      backgroundColor: color,
      content: Text(
        textMessage,
        textAlign: TextAlign.center,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Future<void> savePrefs(
      {required dynamic type,
      required String key,
      required dynamic value}) async {
    final prefs = PreferencesUser();

    prefs.savePrefs(type: type, key: key, value: value);
  }

  @override
  Future<dynamic> loadPrefs(
      {required dynamic type, required String key}) async {
    final prefs = PreferencesUser();

    return await prefs.loadPrefs(type: type, key: key);
  }

  @override
  Future<List<dynamic>> registerFirebaseWithEmail(
      {required String email,
      required String password,
      required String username}) async {
    final prefs = PreferencesUser();

    final respCheck = await checkUserForEmail(email: email);

    if (respCheck[0] == 200) {
      return [0, 'Email ya en uso, Favor de Loguearse'];
    } else {
      try {
        final resp = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String? idUser = resp.user?.uid;
        final respCreate = await createNewUser(
            email: email, idFirebase: idUser!, username: username);

        if (respCreate[0] == 201) {
          prefs.savePrefs(type: String, key: 'tokenFirebase', value: idUser);
          return [1, respCreate[1]];
        } else {
          return [0, respCreate[0].toString() + respCreate[1]];
        }
      } on FirebaseAuthException catch (e) {
        String errorDesc = errorConvert(e.code);

        return [0, errorDesc];
      }
    }
  }

  @override
  Future<List<dynamic>> loginUserForEmail(
      {required String email, required String password}) async {
    final prefs = PreferencesUser();

    try {
      final resp = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String? idUser = resp.user?.uid;
      return [1, idUser ?? ''];
    } on FirebaseAuthException catch (e) {
      String errorDesc = errorConvert(e.code);

      return [0, errorDesc];
    }
  }

  @override
  Future<List<dynamic>> changePasswordFirebase({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

    return [1, ''];
  }

  @override
  Future<List<dynamic>> getDataGoogle() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      List dataUser = [googleUser.email, googleUser.displayName, credential];
      return [1, dataUser];
    } catch (e) {
      return [0, e.toString()];
    }
  }

  @override
  Future<List<dynamic>> loginFirebaseWithGoogle(
      {required OAuthCredential credential, required String email}) async {
    try {
      final respCheck = await checkUserForEmail(email: email);

      if (respCheck == 200) {
        final resp =
            await FirebaseAuth.instance.signInWithCredential(credential);

        String? idUser = resp.user?.uid;
        return [1, idUser];
      } else {
        return [0, 'No se encontro cuenta con email seleccionado'];
      }
    } on FirebaseAuthException catch (e) {
      String errorDesc = errorConvert(e.code);

      return [0, errorDesc];
    }
  }

  @override
  Future<List<dynamic>> registerFirebaseWithGoogle(
      {required OAuthCredential credential,
      required String email,
      required String username}) async {
    try {
      final prefs = PreferencesUser();
      final respCheck = await checkUserForEmail(email: email);

      if (respCheck[0] == 200) {
        return [0, 'Correo ya en uso, intente con otro correo'];
      } else {
        final resp =
            await FirebaseAuth.instance.signInWithCredential(credential);

        String? idUser = resp.user?.uid;

        final respCreate = await createNewUser(
            email: email, username: username, idFirebase: idUser!);
        if (respCreate[0] == 201) {
          prefs.savePrefs(type: String, key: 'tokenFirebase', value: idUser);
          return [1, respCreate[1]];
        } else {
          return [0, respCreate[0].toString() + respCreate[1]];
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorDesc = errorConvert(e.code);

      return [0, errorDesc];
    }
  }

  @override
  Future<List<dynamic>> checkUserForEmail({required String email}) async {
    final resp = await ApiUser().checkUserForEmail(email: email);
    return resp;
  }

  @override
  Future<List<dynamic>> createNewUser(
      {required String email,
      required String username,
      required String idFirebase}) async {
    final resp = await ApiUser()
        .createUser(email: email, idFirebase: idFirebase, username: username);
    return resp;
  }
}
