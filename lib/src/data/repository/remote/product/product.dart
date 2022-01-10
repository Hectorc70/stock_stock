import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/models/product/product_model.dart';

class ApiProduct {
  Future<List<dynamic>> getProducts({required String idShop}) async {
    Uri url = Uri.parse(baseURLAPI + 'users/products/$idShop');

    PreferencesUser prefs = PreferencesUser();
    final token = await prefs.loadPrefs(type: String, key: 'tokenUser');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': tokenInit},
      );

      if (response.statusCode == 200) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8) as List;
        List<ProductModel> products =
            responseDecode.map((json) => ProductModel.fromJson(json)).toList();

        return [response.statusCode, products];
      } else {
        return [response.statusCode, jsonDecode(response.body).toString()];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }
}
