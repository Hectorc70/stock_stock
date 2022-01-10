import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/models/shop/shop_model.dart';

class ApiShop {
  Future<List<dynamic>> createShop(
      {required String nameShop, required String user}) async {
    Uri url = Uri.parse(baseURLAPI + 'users/shop/');

    PreferencesUser prefs = PreferencesUser();
    final token = await prefs.loadPrefs(type: String, key: 'tokenUser');

    try {
      final response = await http.post(url,
          headers: {'Authorization': tokenInit},
          body: {"name": nameShop, "user": user});

      if (response.statusCode == 201) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8);
        ShopModel model = ShopModel.fromJson(responseDecode);
        return [response.statusCode, model];
      } else {
        return [response.statusCode, jsonDecode(response.body).toString()];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }
}
