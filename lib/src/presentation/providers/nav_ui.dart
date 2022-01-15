import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _select = 0;
  bool _isFormproduct = true;

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
}
