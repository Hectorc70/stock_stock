import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_stock/src/data/repository/repository_implementation.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';

final loginProvider = ChangeNotifierProvider<LoginController>((ref) {
  final _repository = ref.read(repositoryProvider);
  return LoginController(repositoryInterface: _repository);
});

class LoginController extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  LoginController({required this.repositoryInterface});
}
