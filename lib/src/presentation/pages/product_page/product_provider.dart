import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/models/product/product_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class ProductProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  ProductProvider({required this.repositoryInterface});

  bool _isEdit = false;
  bool _isLoading = false;
  ProductModel _detailProduct = ProductModel();

  set isEdit(bool value) {
    _isEdit = value;
    notifyListeners();
  }

  bool get isEdit => _isEdit;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set detailProduct(ProductModel value) {
    _detailProduct = value;
    notifyListeners();
  }

  ProductModel get detailProduct => _detailProduct;
}
