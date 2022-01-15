import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/models/sale/sale_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class SalesProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  SalesProvider({
    required this.repositoryInterface,
  });

  bool _isLoading = false;
  List<SaleModel> _sales = [];

  set isLoading(bool data) {
    _isLoading = data;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set sales(List<SaleModel> data) {
    _sales = data;
    notifyListeners();
  }

  List<SaleModel> get sales => _sales;
}
