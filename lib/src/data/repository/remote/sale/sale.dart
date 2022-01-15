import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/models/sale/sale_model.dart';

class ApiSale {
  String tokenUser = '';
  Future<List<dynamic>> newSale({
    required SaleModel model,
  }) async {
    Uri url = Uri.parse(baseURLAPI + 'users/sale/');

    try {
      await loadToken();
      final response = await http.post(url,
          headers: {'Authorization': 'Token $tokenUser'}, body: model.toJson());

      if (response.statusCode == 201) {
        return [response.statusCode, ''];
      } else if (response.statusCode == 400 &&
          jsonDecode(response.body).length > 0) {
        return [response.statusCode, jsonDecode(response.body)['error']];
      } else {
        return [response.statusCode, response.reasonPhrase];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }

  Future<List<dynamic>> getSales({
    required String idShop,
  }) async {
    Uri url = Uri.parse(baseURLAPI + 'users/sales/$idShop');

    try {
      await loadToken();
      final response = await http.get(
        url,
        headers: {'Authorization': 'Token $tokenUser'},
      );

      if (response.statusCode == 200) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8) as List;
        List<SaleModel> sales =
            responseDecode.map((json) => SaleModel.fromJson(json)).toList();
        return [response.statusCode, sales];
      } else {
        return [response.statusCode, response.reasonPhrase];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }

  Future<List<dynamic>> getSalesForDate({
    required String date,
    required String shop,
  }) async {
    Uri url = Uri.parse(baseURLAPI + 'users/sales-for-date/');

    try {
      await loadToken();
      final response = await http.post(url,
          headers: {'Authorization': 'Token $tokenUser'},
          body: {'date': date, 'shop': shop});

      if (response.statusCode == 200) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8) as List;
        final sales =
            responseDecode[0].map((json) => SaleModel.fromJson(json)).toList();
        return [response.statusCode, sales, responseDecode[1]];
      } else {
        return [response.statusCode, response.reasonPhrase];
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
