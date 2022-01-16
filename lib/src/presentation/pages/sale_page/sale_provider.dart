import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/models/sale/sale_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class SaleProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  SaleProvider({
    required this.repositoryInterface,
  });

  bool _isLoading = false;
  SaleModel _saleDetail = SaleModel();
  bool _isEdit = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set saleDetail(SaleModel value) {
    _saleDetail = value;
    notifyListeners();
  }

  SaleModel get saleDetail => _saleDetail;
}
