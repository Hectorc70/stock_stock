import 'package:flutter/cupertino.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

class LoginProvider extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;

  LoginProvider({required this.repositoryInterface});
}
