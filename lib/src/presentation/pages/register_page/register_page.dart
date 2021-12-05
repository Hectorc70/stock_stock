import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/assets_constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/google_container.dart';
import 'package:stock_stock/src/presentation/widgets/login_header_widget.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginProvider(
            repositoryInterface: context.read<RepositoryInterface>()),
        builder: (_, __) {
          return const RegisterPage();
        });
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          logoWidget(),
          const SizedBox(
            height: 30.0,
          ),
          Text(
            'Registro con email',
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
                child: Column(
              children: [
                CustomFormEmailField(
                  labelField: 'Correo electronico',
                ),
                CustomFormField(
                  labelField: 'Nombre de usuario',
                  hintField: 'ejemplo:Juan Perez',
                ),
                CustomFormPasswordField(
                  labelField: 'Contraseña',
                ),
                const SizedBox(
                  height: 30.0,
                ),
                ButtonPrimary(
                  actionButton: () {},
                  textButton: 'Aceptar',
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: widthScreen * .40,
                      color: Theme.of(context).colorScheme.primary,
                      height: 1,
                    ),
                    Text(
                      'O',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Container(
                      width: widthScreen * .40,
                      color: Theme.of(context).colorScheme.primary,
                      height: 1,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                googleButton(action: () {}),
              ],
            )),
          ),
        ],
      )),
    );
  }
}
