import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_stock/main.dart';
import 'package:stock_stock/src/data/repository/remote/user/user.dart';
import 'package:stock_stock/src/data/repository/repository_implementation.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

final splashProvider = ChangeNotifierProvider<SplashController>((ref) {
  return SplashController(repositoryInterface: ref.read(repositoryProvider))
    ..init();
});

class SplashController extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  SplashController({required this.repositoryInterface});

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

  void init() async {
    final result = await loadData();

    if (result[0] == 0) {
      repositoryInterface.showSnack(textMessage: result[1], typeSnack: 'error');
    } else if (result[0] == 1 && result[1].shops.length == 0) {
      // userProvider.dataUser = result[1];
      navigatorKey.currentState!.pushReplacementNamed('newShopPage');
    } else if (result[0] == 1) {
      // userProvider.dataUser = result[1];
      // userProvider.selectShop = result[1].shops[0].split(':')[0];
      navigatorKey.currentState!.pushReplacementNamed('homePage');
    } else {
      navigatorKey.currentState!.pushReplacementNamed('loginPage');
    }
  }
}
