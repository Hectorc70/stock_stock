import 'package:flutter/material.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class RegisterProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;
  RegisterProvider({required this.repositoryInterface});
}
