import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/models/product/product_model.dart';
import 'package:stock_stock/src/domain/models/user/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel _dataUser = UserModel();
  String _selectShop = '';
  List<Map<String, dynamic>> _productsItemsSelect = [];
  Map<String, ProductModel> _productsMapSelect = {};

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

  set productsItemsSelect(List<Map<String, dynamic>> data) {
    _productsItemsSelect = data;
    notifyListeners();
  }

  List<Map<String, dynamic>> get productsItemsSelect => _productsItemsSelect;

  set productsMapSelect(Map<String, ProductModel> data) {
    _productsMapSelect = data;
    notifyListeners();
  }

  Map<String, ProductModel> get productsMapSelect => _productsMapSelect;
}
