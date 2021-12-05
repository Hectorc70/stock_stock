import 'package:flutter/cupertino.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class SplashProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  SplashProvider({required this.repositoryInterface});

  Future<bool> loadData() async {
    final resp =
        await repositoryInterface.loadPrefs(type: String, key: 'tokenAuth');

    if (resp != null) {
      print('HOME');
      return true;
    } else {
      return false;
    }
  }
}
