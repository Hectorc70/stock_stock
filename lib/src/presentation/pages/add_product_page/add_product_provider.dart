import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class AddProductProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  AddProductProvider({required this.repositoryInterface});
}
