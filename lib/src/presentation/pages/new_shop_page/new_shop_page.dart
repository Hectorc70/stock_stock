import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/new_shop_page/new_shop_provider.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/loader_widget.dart';
import 'package:stock_stock/src/presentation/widgets/messages_popup.dart';

class NewShopPage extends StatefulWidget {
  const NewShopPage({Key? key}) : super(key: key);

  @override
  _NewShopPageState createState() => _NewShopPageState();
}

class _NewShopPageState extends State<NewShopPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewShopProvider(
          repositoryInterface: context.read<RepositoryInterface>()),
      child: _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  _Body({Key? key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  TextEditingController controllerNameShop = TextEditingController();
  TextEditingController controllerEmailEmploye = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controllerNameShop.dispose();
    controllerEmailEmploye.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthScreen = MediaQuery.of(context).size.width;
    final provider = Provider.of<NewShopProvider>(
      context,
    );
    final userprovider = Provider.of<UserProvider>(
      context,
    );
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              'Crear Negocio',
              style: Theme.of(context).textTheme.headline5,
            ),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                        labelField: 'Nombre de Negocio',
                        hintField: 'ejem: Paletas Rosa',
                        controller: controllerNameShop)
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
            child: ButtonPrimary(
                widthButton: widthScreen * 0.80,
                textButton: 'Crear',
                actionButton: () async {
                  if (_formKey.currentState!.validate()) {
                    loaderView(context);
                    final resp = await provider.repositoryInterface
                        .createNewShop(
                            idUser: userprovider.dataUser.id.toString(),
                            nameShop: controllerNameShop.text);
                    Loader.hide();
                    if (resp[0] == 201) {
                      userprovider.selectShop = resp[1].id.toString();
                      messageOK(
                          context: context,
                          msg: 'Negocio creado correctamente');
                      Future.delayed(Duration(seconds: 2), () {
                        Navigator.of(context).pushNamed('homePage');
                      });
                    } else {
                      provider.repositoryInterface.showSnack(
                          context: context,
                          textMessage: resp[1],
                          typeSnack: 'error');
                    }
                  }
                }),
          ),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }
}
