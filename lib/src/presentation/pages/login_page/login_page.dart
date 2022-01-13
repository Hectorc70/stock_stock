import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/assets_constants.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/google_container.dart';
import 'package:stock_stock/src/presentation/widgets/login_header_widget.dart';

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
                child: Column(
              children: [
                /*   CustomFormEmailField(
                  labelField: 'Correo electronico',
                ),
                CustomFormPasswordField(
                  labelField: 'Contraseña',
                ), */
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
                  actionButton: () {},
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
                googleButton(action: () {}),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('¿No tienes cuenta?'),
                    TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('registerPage'),
                        child: Text('Registrate'))
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
