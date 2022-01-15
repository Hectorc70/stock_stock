import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/models/product/product_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/product_form/product_provider.dart';
import 'package:stock_stock/src/presentation/providers/nav_ui.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/loader_widget.dart';
import 'package:stock_stock/src/presentation/widgets/messages_popup.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductProvider(
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
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPieces = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();



  @override
  void dispose() {
    controllerName.dispose();
    controllerPieces.dispose();
    controllerPrice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final BannerAd myBanner = BannerAd(
      adUnitId: idBanner,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();

    if (uiProvider.isFormproduct) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            'Crear Producto',
            style: Theme.of(context).textTheme.headline6,
          ),
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 30.0,
                color: Theme.of(context).colorScheme.secondary,
              )),
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomFormField(
                            labelField: 'Nombre de Producto',
                            hintField: 'ejemplo:Paleta',
                            controller: controllerName),
                        CustomFormPiecesField(
                            labelField: 'Precio de Producto',
                            hintField: 'ejemplo: 20.0',
                            controller: controllerPrice),
                        CustomFormPiecesField(
                            labelField: 'Piezas de Producto',
                            hintField: 'ejemplo: 100',
                            controller: controllerPieces),
                      ],
                    )),
              ),
            ),
            const Spacer(),
            ButtonPrimary(
                textButton: 'GUARDAR',
                actionButton: () async {
                  if (_formKey.currentState!.validate()) {
                    loaderView(context);
                    final resp = await productProvider.repositoryInterface
                        .createProductForShop(
                            productModel: ProductModel(
                      name: controllerName.text,
                      pieces: int.parse(controllerPieces.text),
                      price: double.parse(controllerPrice.text),
                      shopId: int.parse(userProvider.selectShop),
                    ));
                    Loader.hide();
                    if (resp[0] == 201) {
                      messageOK(
                          context: context,
                          msg: 'Producto Creado',
                          action: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('productsPage');
                          });
                    } else {
                      productProvider.repositoryInterface.showSnack(
                          context: context,
                          textMessage: resp[1],
                          typeSnack: 'error');
                    }
                  }
                })
          ],
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          child: AdWidget(ad: myBanner),
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Detalle de Producto',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30.0,
              color: Theme.of(context).colorScheme.secondary,
            )),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
    );
  }
}
