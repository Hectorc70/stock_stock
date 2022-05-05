import 'dart:convert';

import 'package:stock_stock/src/core/constants/constants.dart';
import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:http/http.dart' as http;
import 'package:stock_stock/src/domain/models/user/user_model.dart';
import 'package:stock_stock/src/domain/models/user/user_request_model.dart';
import 'package:stock_stock/src/domain/models/user/user_response_model.dart';

class ApiUser {
  Future<UserResponseModel> createUser({
    required UserRequestModel model,
  }) async {
    Uri url = Uri.parse(baseURLAPI + 'users/user/');

    try {
      final data = jsonEncode(model.toJson());
      final response = await http.post(url, headers: {
        'Content-Type': 'application/json',
        'Authorization': tokenInit
      }, body: {
        data
      });

      if (response.statusCode == 201) {
        final dataUTF8 = utf8.decode(response.bodyBytes);
        final responseDecode = jsonDecode(dataUTF8);
        UserModel model = UserModel.fromJson(responseDecode);
        return UserResponseModel(
            data: model,
            statusCode: response.statusCode,
            message: 'Usuario creado con Exito');
      } else if (response.statusCode != 201 && response.body.toString() != '') {
        return UserResponseModel(
            data: UserModel(),
            statusCode: response.statusCode,
            message: jsonDecode(response.body).toString());
      } else {
        return UserResponseModel(
            data: UserModel(),
            statusCode: response.statusCode,
            message: response.reasonPhrase.toString());
      }
    } catch (e) {
      return UserResponseModel(
          data: UserModel(), statusCode: 0, message: e.toString());
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
