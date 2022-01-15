import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/models/sale/sale_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class HomeProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  HomeProvider({
    required this.repositoryInterface,
  });

  String _date = DateTime.now().toString().split(' ')[0];
  double _totalToday = 0.0;
  bool _isLoading = false;
  List<dynamic> _sales = [];

  set isLoading(bool data) {
    _isLoading = data;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set sales(data) {
    _sales = data;
    notifyListeners();
  }

  get sales => _sales;

  set totalToday(double data) {
    _totalToday = data;
    notifyListeners();
  }

  double get totalToday => _totalToday;

  set date(String data) {
    _date = data;
    notifyListeners();
  }

  String get date => _date;
}
