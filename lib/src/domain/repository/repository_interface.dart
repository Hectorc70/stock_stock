abstract class RepositoryInterface {
  Future<void> savePrefs({required dynamic type, required String key, required dynamic value});
  Future<dynamic> loadPrefs({required dynamic type, required String key});
  Future register();
  Future login();
}
