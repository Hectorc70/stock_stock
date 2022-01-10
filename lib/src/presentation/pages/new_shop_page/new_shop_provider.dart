import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class NewShopProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;
  NewShopProvider({required this.repositoryInterface});
}
