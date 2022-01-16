import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _select = 0;
  bool _isFormproduct = true;
  bool _isFormSale = true;
  int _idSaleSelect = 0;

  set selectOption(int i) {
    _select = i;
    notifyListeners();
  }

  int get selectOption => _select;

  set isFormproduct(bool i) {
    _isFormproduct = i;
    notifyListeners();
  }

  bool get isFormproduct => _isFormproduct;

  set isFormSale(bool i) {
    _isFormSale = i;
    notifyListeners();
  }

  bool get isFormSale => _isFormSale;

  set idSaleSelect(int i) {
    _idSaleSelect = i;
    notifyListeners();
  }

  int get idSaleSelect => _idSaleSelect;
}
