import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/assets_constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginProvider(
            repositoryInterface: context.read<RepositoryInterface>()),
        builder: (_, __) {
          return const LoginPage();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Image.asset(logoGreen),
      ),
    );
  }
}
