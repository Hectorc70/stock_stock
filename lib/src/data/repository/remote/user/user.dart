import 'dart:convert';

import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:stock_stock/src/domain/models/user/user_model.dart';

class ApiUser {
  Future<List<dynamic>> createUser(
      {required String email,
      required String username,
      required String idFirebase}) async {
    Uri url = Uri.parse(baseURLAPI + 'users/user/');

    try {
      final response = await http.post(url, headers: {
        'Authorization': tokenInit
      }, body: {
        "username": username,
        "email": email,
        "id_firebase": idFirebase
      });

      if (response.statusCode == 201) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8);
        UserModel model = UserModel.fromJson(responseDecode);
        return [response.statusCode, model];
      } else {
        return [response.statusCode, jsonDecode(response.body)];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }

  Future<List<dynamic>> updateDataUser({
    required Map data,
    required String idFirebase,
  }) async {
    Uri url = Uri.parse(baseURLAPI + 'users/user/$idFirebase');

    try {
      final response = await http.put(url,
          headers: {'Authorization': tokenInit}, body: data);

      if (response.statusCode == 200) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8);
        UserModel model = UserModel.fromJson(responseDecode);
        return [response.statusCode, model];
      } else {
        return [response.statusCode, jsonDecode(response.body)];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }

  Future<List<dynamic>> getUserFirebase({required String idFirebase}) async {
    Uri url = Uri.parse(baseURLAPI + 'users/user/$idFirebase');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': tokenInit},
      );

      if (response.statusCode == 200) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8);
        UserModel model = UserModel.fromJson(responseDecode);
        return [response.statusCode, model];
      } else {
        return [response.statusCode, response.reasonPhrase];
      }
    } catch (e) {
      return [0, e.toString()];
    }
  }

  Future<List<dynamic>> checkUserForEmail({required String email}) async {
    Uri url = Uri.parse(baseURLAPI + 'users/user-check-for-email/');

    try {
      final response = await http.post(url, headers: {
        'Authorization': tokenInit
      }, body: {
        "email": email,
      });
      return [response.statusCode, ''];
    } catch (e) {
      return [0, e.toString()];
    }
  }
}
