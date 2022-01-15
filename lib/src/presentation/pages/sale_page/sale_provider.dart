import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class SaleProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  SaleProvider({
    required this.repositoryInterface,
  });

  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
