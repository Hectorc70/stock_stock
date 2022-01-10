import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _select = 0;

  set selectOption(int i) {
    _select = i;
    notifyListeners();
  } 
  int get selectOption => _select;
  
}



