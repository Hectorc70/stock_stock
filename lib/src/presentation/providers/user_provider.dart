import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/models/user/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _dataUser = UserModel();
  String _selectShop = '';

  set dataUser(UserModel data) {
    _dataUser = data;
    notifyListeners();
  }

  UserModel get dataUser => _dataUser;

  
  set selectShop(String data) {
    _selectShop = data;
    notifyListeners();
  }

  String get selectShop => _selectShop;
}
