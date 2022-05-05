import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_stock/main.dart';
import 'package:stock_stock/src/data/repository/repository_implementation.dart';
import 'package:stock_stock/src/domain/models/user/user_request_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/routes/routes.dart';

final registerProvider =
    ChangeNotifierProvider.autoDispose<RegisterNotifier>((ref) {
  final _repository = ref.read(repositoryProvider);
  return RegisterNotifier(
      repositoryInterface: _repository, userProvider: ref.read(userProvider));
});

class RegisterNotifier extends ChangeNotifier {
  late RepositoryInterface repositoryInterface;
  late UserController userProvider;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNameUser = TextEditingController();
  TextEditingController controllerLastNameUser = TextEditingController();
  TextEditingController controllerSecondLastNameUser = TextEditingController();
  TextEditingController controllerTypeAcount = TextEditingController();

  String _typeView = 'options';
  bool _isLoading = false;
  bool _isEmployee = false;

  RegisterNotifier({
    required RepositoryInterface repositoryInterface,
    required UserController userProvider,
  }) {
    repositoryInterface = repositoryInterface;
    userProvider = userProvider;
  }

  set isEmployee(bool value) {
    _isEmployee = value;
    notifyListeners();
  }

  bool get isEmployee => _isEmployee;

  set changeTypeView(String value) {
    _typeView = value;
    notifyListeners();
  }

  String get typeView => _typeView;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  Future<void> registerUserEmail() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      final resp = await repositoryInterface.registerFirebaseWithEmail(
          password: controllerPassword.text,
          model: UserRequestModel(
            email: controllerEmail.text,
            typeAcount: controllerTypeAcount.text,
            names: controllerNameUser.text,
            lastName: controllerLastNameUser.text,
            secondLastName: controllerSecondLastNameUser.text,
          ));
      isLoading = false;

      if (resp.statusCode == 1) {
        userProvider.dataUser = resp.data;
        navigatorKey.currentState!.pushNamed(homePage);
      } else {
        repositoryInterface.showSnack(
            textMessage: resp.message, typeSnack: 'error');
      }
    }
  }
}
