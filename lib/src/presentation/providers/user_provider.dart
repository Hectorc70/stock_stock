import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_stock/src/data/repository/repository_implementation.dart';
import 'package:stock_stock/src/domain/models/product/product_model.dart';
import 'package:stock_stock/src/domain/models/user/user_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

final userProvider = ChangeNotifierProvider<UserController>((ref) {
  final _repository = ref.read(repositoryProvider);
  return UserController(
    repositoryInterface: _repository,
  );
});

class UserController extends ChangeNotifier {
  UserModel _dataUser = UserModel();
  String _selectShop = '';
  String _id_device = '';
  List<Map<String, dynamic>> _productsItemsSelect = [];
  Map<String, ProductModel> _productsMapSelect = {};

  UserController({
    required RepositoryInterface repositoryInterface,
  });
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

  set id_device(value) {
    _id_device = value;
    notifyListeners();
  }

  get id_device => _id_device;

  Future<void> getTokenDevice() async {
    id_device = await FirebaseMessaging.instance.getToken();
  }
}




class UserProvider extends ChangeNotifier {
  UserModel _dataUser = UserModel();
  String _selectShop = '';
  String _id_device = '';
  List<Map<String, dynamic>> _productsItemsSelect = [];
  Map<String, ProductModel> _productsMapSelect = {};

  UserProvider({
    required RepositoryInterface repositoryInterface,
  });
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

  set id_device(value) {
    _id_device = value;
    notifyListeners();
  }

  get id_device => _id_device;

  Future<void> getTokenDevice() async {
    id_device = await FirebaseMessaging.instance.getToken();
  }
}