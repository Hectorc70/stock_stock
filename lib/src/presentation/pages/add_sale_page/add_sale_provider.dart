import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class AddSaleProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  AddSaleProvider({
    required this.repositoryInterface,
  });

  bool _isLoading = false;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
}
