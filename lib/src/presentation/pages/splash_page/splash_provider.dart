import 'package:flutter/cupertino.dart';
import 'package:stock_stock/src/data/repository/remote/user/user.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class SplashProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  SplashProvider({required this.repositoryInterface});

  Future<List<dynamic>> loadData() async {
    try {
      final resp = await repositoryInterface.loadPrefs(
          type: String, key: 'tokenFirebase');

      if (resp != null) {
        final data = await ApiUser().getUserFirebase(idFirebase: resp);
        if (data[0] == 200) {
          return [1, data[1]];
        }

        return [0, data[1]];
      }
      return [
        2,
      ];
    } catch (e) {
      return [0, e.toString()];
    }
  }
}
