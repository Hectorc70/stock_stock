import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _select = 0;

  int _idSaleSelect = 0;
  int _idProductSelect = 0;

  set selectOption(int i) {
    _select = i;
    notifyListeners();
  }

  int get selectOption => _select;

  set idSaleSelect(int i) {
    _idSaleSelect = i;
    notifyListeners();
  }

  int get idSaleSelect => _idSaleSelect;

  set idProductSelect(int i) {
    _idProductSelect = i;
    notifyListeners();
  }

  int get idProductSelect => _idProductSelect;
}
