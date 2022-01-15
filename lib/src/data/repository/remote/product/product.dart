import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/models/product/product_model.dart';

class ApiProduct {
  String tokenUser = '';

  Future<List<dynamic>> getProducts({required String idShop}) async {
    Uri url = Uri.parse(baseURLAPI + 'users/products/$idShop');

    try {
      await loadToken();
      final response = await http.get(
        url,
        headers: {'Authorization': 'Token $tokenUser'},
      );

      if (response.statusCode == 200) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8) as List;
        List<ProductModel> products =
            responseDecode.map((json) => ProductModel.fromJson(json)).toList();
        List<Map<String, dynamic>> productsSelectItem = responseDecode
            .map((json) => ProductModel().fromJsonToSelectItem(json))
            .toList();
        Map<String, ProductModel> productsMap = ProductModel().fromJsonToMapSelect(responseDecode);

        return [response.statusCode, products, productsSelectItem, productsMap];
      } else {
        return [response.statusCode, jsonDecode(response.body).toString()];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }

  Future<List<dynamic>> newProduct({required ProductModel model}) async {
    Uri url = Uri.parse(baseURLAPI + 'users/product/');

    try {
      await loadToken();
      final response = await http.post(url,
          headers: {'Authorization': 'Token $tokenUser'}, body: model.toJson());

      if (response.statusCode == 201) {
        return [response.statusCode, ''];
      } else {
        return [response.statusCode, jsonDecode(response.body).toString()];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }

  Future<List<dynamic>> getProduct({required String idProduct}) async {
    Uri url = Uri.parse(baseURLAPI + 'users/product/$idProduct');

    try {
      await loadToken();
      final response = await http.get(
        url,
        headers: {'Authorization': 'Token $tokenUser'},
      );

      if (response.statusCode == 200) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8);
        ProductModel product = ProductModel.fromJson(responseDecode);

        return [response.statusCode, product];
      } else {
        return [response.statusCode, jsonDecode(response.body).toString()];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }

  Future<void> loadToken() async {
    PreferencesUser prefs = PreferencesUser();
    tokenUser = await prefs.loadPrefs(type: String, key: 'tokenUser');
  }
}
