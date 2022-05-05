import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stock_stock/src/core/constants/constants.dart';
import 'package:stock_stock/src/presentation/pages/register_page/register_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/google_container.dart';
import 'package:stock_stock/src/presentation/widgets/login_header_widget.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final widthScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;
    // final userProvider = Provider.of<UserProvider>(context);
    final _registerProvider = ref.read(registerProvider);
    final BannerAd myBanner = BannerAd(
      adUnitId: idBanner,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: const BannerAdListener(),
    );
    myBanner.load();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        toolbarHeight: 120.0,
        flexibleSpace: logoWidget(),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
          child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(
            height: 30.0,
          ),
          Consumer(builder: (_, WidgetRef ref, child) {
            return ref.watch(registerProvider).typeView == 'options'
                ? Text(
                    'Opciones de Registro',
                    style: Theme.of(context).textTheme.headline5,
                  )
                : Text(
                    'Registro con email',
                    style: Theme.of(context).textTheme.headline5,
                  );
          }),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Consumer(builder: (_, WidgetRef ref, child) {
                if (ref.watch(registerProvider).typeView == 'options') {
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      googleButton(action: () {
                        /* final resp = await registerProvider.repositoryInterface
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
                      } */
                      }),
                      const SizedBox(
                        width: 20.0,
                      ),
                      emailButton(
                          context: context,
                          action: () {
                            _registerProvider.changeTypeView = 'email';
                          })
                    ],
                  );
                } else if (ref.watch(registerProvider).typeView == 'email') {
                  return Form(
                      key: _registerProvider.formKey,
                      child: Column(
                        children: [
                          CustomFormSelectField(
                              onSelect: (value) {
                                _registerProvider.controllerTypeAcount.text =
                                    value.toString();
                                if (value == 'Empleado') {
                                  _registerProvider.isEmployee = true;
                                } else {
                                  _registerProvider.isEmployee = false;
                                }
                              },
                              hintField: 'Selecciona',
                              labelField: 'Tipo de Cuenta',
                              controller:
                                  _registerProvider.controllerTypeAcount,
                              items: const [
                                PopupMenuItem(
                                  value: 'Dueño',
                                  child: Text('Dueño'),
                                ),
                                PopupMenuItem(
                                  value: 'Empleado',
                                  child: Text('Empleado'),
                                ),
                              ]),
                          _registerProvider.isEmployee
                              ? CustomFormField(
                                  labelField: 'Codigo de Tienda',
                                  hintField: 'Ingrese Codigo',
                                  controller: _registerProvider.controllerEmail,
                                )
                              : const SizedBox(),
                          CustomFormEmailField(
                            labelField: 'Correo electronico',
                            controller: _registerProvider.controllerEmail,
                          ),
                          CustomFormField(
                            labelField: 'Nombres',
                            hintField: 'ejemplo: Juan',
                            controller: _registerProvider.controllerNameUser,
                          ),
                          CustomFormField(
                            labelField: 'Primer Apellido',
                            hintField: 'ejemplo: Perez',
                            controller:
                                _registerProvider.controllerLastNameUser,
                          ),
                          CustomFormField(
                            labelField: 'Segundo Apellido',
                            hintField: 'ejemplo: Garcia',
                            controller:
                                _registerProvider.controllerSecondLastNameUser,
                          ),
                          CustomFormPasswordField(
                            labelField: 'Contraseña',
                            controller: _registerProvider.controllerPassword,
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ButtonPrimary(
                              textButton: 'Aceptar',
                              actionButton: () async {
                                await _registerProvider.registerUserEmail();
                              }),
                        ],
                      ));
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    googleButton(action: () {
                      /* final resp = await registerProvider.repositoryInterface
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
                      } */
                    }),
                    const SizedBox(
                      width: 20.0,
                    ),
                    emailButton(
                        context: context,
                        action: () {
                          _registerProvider.changeTypeView = 'email';
                        })
                  ],
                );
              })),
        ],
      )),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        child: AdWidget(ad: myBanner),
        width: myBanner.size.width.toDouble(),
        height: myBanner.size.height.toDouble(),
      ),
    );
  }
}
