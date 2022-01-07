import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:stock_stock/src/data/repository/local/translate_errors_firebase.dart';
import 'package:stock_stock/src/data/repository/remote/user/user.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class RepositoryImplementation implements RepositoryInterface {
  @override
  Future<void> savePrefs(
      {required dynamic type,
      required String key,
      required dynamic value}) async {}
  @override
  Future<void> loadPrefs({required dynamic type, required String key}) async {}
  @override
  Future register() async {}
  @override
  Future login() async {}
  @override
  Future<List<dynamic>> registerFirebaseWithEmail(
      {required String email, required String password}) async {
    final prefs = PreferencesUser();

    final respCheck = await getUserForEmail(email: email);

    if (respCheck == 200) {
      return [0, 'Email ya en uso, Favor de Loguearse'];
    } else {
      final resp = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String? idUser = resp.user?.uid;
      prefs.savePrefs(type: String, key: 'tokenFirebase', value: idUser);
      return [1, idUser];
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
      {required OAuthCredential credential}) async {
    try {
      final resp = await FirebaseAuth.instance.signInWithCredential(credential);

      String? idUser = resp.user?.uid;
      return [1, idUser];
    } catch (e) {
      return [0, ''];
    }
  }

  @override
  Future<List<dynamic>> getUserForEmail({required String email}) async {
    await ApiUser().getUserForEmail(email: email);
    return [];
  }
}
