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
}
