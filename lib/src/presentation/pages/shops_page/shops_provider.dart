import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class ShopsProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;
  ShopsProvider({required this.repositoryInterface});

  bool _isLoading = false;

  set isLoading(bool data) {
    _isLoading = data;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
