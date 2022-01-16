import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/assets_constants.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_provider.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/google_container.dart';
import 'package:stock_stock/src/presentation/widgets/loader_widget.dart';
import 'package:stock_stock/src/presentation/widgets/login_header_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginProvider(
            repositoryInterface: context.read<RepositoryInterface>()),
        builder: (_, __) {
          return _Body();
        });
  }
}

class _Body extends StatefulWidget {
  _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(
      context,
    );
    final userProvider = Provider.of<UserProvider>(context);
    final BannerAd myBanner = BannerAd(
      adUnitId: idBanner,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();

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
            'Login con email',
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
                    CustomFormPasswordField(
                      labelField: 'Contraseña',
                      controller: controllerPassword,
                    ),
                    Container(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'recuperar contraseña',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF7FB3C5),
                              ),
                            ))),
                    ButtonPrimary(
                      actionButton: () async {
                        if (_formKey.currentState!.validate()) {
                          loaderView(context);
                          final resp = await loginProvider.repositoryInterface
                              .loginFirebaseWithEmail(
                                  email: controllerEmail.text,
                                  password: controllerPassword.text);
                          Loader.hide();
                          if (resp[0] == 1) {
                            userProvider.dataUser = resp[1];
                            loginProvider.repositoryInterface.savePrefs(
                                type: String,
                                key: 'tokenUser',
                                value: userProvider.dataUser.tokenUser);
                            loaderView(context);
                            await loginProvider.repositoryInterface.updateUser(
                                data: {'id_device': userProvider.id_device},
                                idFirebase: userProvider.dataUser.idFirebase!);
                            Loader.hide();
                            Navigator.of(context).pushNamed('homepage');
                          } else {
                            loginProvider.repositoryInterface.showSnack(
                                context: context,
                                textMessage: resp[1],
                                typeSnack: 'error');
                          }
                        }
                      },
                      textButton: 'Login',
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
                      final resp = await loginProvider.repositoryInterface
                          .getDataGoogle();
                      if (resp[0] == 1) {
                        loaderView(context);
                        final respL = await loginProvider.repositoryInterface
                            .loginFirebaseWithGoogle(
                          credential: resp[1][2],
                          email: resp[1][0],
                        );

                        Loader.hide();

                        if (respL[0] == 1) {
                          userProvider.dataUser = respL[1];
                          loginProvider.repositoryInterface.savePrefs(
                              type: String,
                              key: 'tokenUser',
                              value: userProvider.dataUser.tokenUser);

                          await loginProvider.repositoryInterface.updateUser(
                              data: {'id_device': userProvider.id_device},
                              idFirebase: userProvider.dataUser.idFirebase!);

                          Navigator.of(context).pushNamed('homePage');
                        } else {
                          loginProvider.repositoryInterface.showSnack(
                              context: context,
                              textMessage: respL[1],
                              typeSnack: 'error');
                        }
                      }
                    }),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('¿No tienes cuenta?'),
                        TextButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('registerPage'),
                            child: const Text('Registrate'))
                      ],
                    ),
                  ],
                )),
          ),
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
