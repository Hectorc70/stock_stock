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
