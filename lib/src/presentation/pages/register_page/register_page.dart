import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/assets_constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_provider.dart';
import 'package:stock_stock/src/presentation/pages/register_page/register_provider.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/google_container.dart';
import 'package:stock_stock/src/presentation/widgets/loader_widget.dart';
import 'package:stock_stock/src/presentation/widgets/login_header_widget.dart';
import 'package:stock_stock/src/presentation/widgets/messages_snack.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterProvider(
            repositoryInterface: context.read<RepositoryInterface>()),
        builder: (_, __) {
          return _Body();
        });
  }
}

class _Body extends StatefulWidget {
  _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNameUser = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerNameUser.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;

    final registerProvider = Provider.of<RegisterProvider>(
      context,
    );
    final userProvider = Provider.of<UserProvider>(context);

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
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormEmailField(
                      labelField: 'Correo electronico',
                      controller: controllerEmail,
                    ),
                    CustomFormField(
                      labelField: 'Nombre de usuario',
                      hintField: 'ejemplo:Juan Perez',
                      controller: controllerNameUser,
                    ),
                    CustomFormPasswordField(
                      labelField: 'Contraseña',
                      controller: controllerPassword,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    ButtonPrimary(
                      actionButton: () async {
                        if (_formKey.currentState!.validate()) {
                          loaderView(context);
                          final resp = await registerProvider
                              .repositoryInterface
                              .registerFirebaseWithEmail(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text,
                                  username: controllerNameUser.text);
                          Loader.hide();
                          if (resp[0] == 1) {
                            userProvider.dataUser = resp[1];
                            registerProvider.repositoryInterface.savePrefs(
                                type: String,
                                key: 'tokenUser',
                                value: userProvider.dataUser.tokenUser);
                            Navigator.of(context).pushNamed('homePage');
                          } else {
                            registerProvider.repositoryInterface.showSnack(
                                context: context,
                                textMessage: resp[1],
                                typeSnack: 'error');
                          }
                        }
                      },
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
                    googleButton(action: () async {
                      final resp = await registerProvider.repositoryInterface
                          .getDataGoogle();

                      if (resp[0] == 1) {
                        loaderView(context);
                        final respR = await registerProvider.repositoryInterface
                            .registerFirebaseWithGoogle(
                                credential: resp[1][2],
                                email: resp[1][0],
                                username: resp[1][1]);
                        Loader.hide();
                        if (respR[0] == 1) {
                          userProvider.dataUser = respR[1];
                          registerProvider.repositoryInterface.savePrefs(
                              type: String,
                              key: 'tokenUser',
                              value: userProvider.dataUser.tokenUser);
                          Navigator.of(context).pushNamed('homePage');
                        } else {
                          registerProvider.repositoryInterface.showSnack(
                              context: context,
                              textMessage: respR[1],
                              typeSnack: 'error');
                        }
                      } else {
                        registerProvider.repositoryInterface.showSnack(
                            context: context,
                            textMessage: resp[1],
                            typeSnack: 'error');
                      }
                    }),
                  ],
                )),
          ),
        ],
      )),
    );
  }
}
