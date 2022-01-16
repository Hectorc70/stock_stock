import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class ProductProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  ProductProvider({required this.repositoryInterface});
}
