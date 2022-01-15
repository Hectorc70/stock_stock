import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/models/product/product_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class ProductsProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  ProductsProvider({
    required this.repositoryInterface,
  });

  bool _isLoading = false;
  List<ProductModel> _products = [];

  set isLoading(bool data) {
    _isLoading = data;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set products(List<ProductModel> data) {
    _products = data;
    notifyListeners();
  }

  List<ProductModel> get products => _products;
}
