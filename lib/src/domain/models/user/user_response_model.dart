import 'package:stock_stock/src/domain/models/user/user_model.dart';

class UserResponseModel {
  int statusCode;
  String message;
  UserModel data;

  UserResponseModel(
      {required this.statusCode, required this.message, required this.data});
}
