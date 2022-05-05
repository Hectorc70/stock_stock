import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/core/constants/constants.dart';
import 'package:stock_stock/src/domain/models/product/product_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/product_page/product_provider.dart';
import 'package:stock_stock/src/presentation/pages/product_page/widgets/product_shimmer.dart';
import 'package:stock_stock/src/presentation/providers/nav_ui.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/loader_widget.dart';
import 'package:stock_stock/src/presentation/widgets/messages_popup.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';
import 'package:stock_stock/src/presentation/widgets/view_data_widget.dart';

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

  void _init() async {
    final prodProvider = Provider.of<ProductProvider>(context, listen: false);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    prodProvider.isLoading = true;
    final result = await prodProvider.repositoryInterface
        .getProductForId(idProduct: uiProvider.idProductSelect.toString());

    if (result[0] == 200) {
      prodProvider.detailProduct = result[1];
    } else {
      Navigator.of(context).pop();
      prodProvider.repositoryInterface.showSnack(
          context: context, textMessage: result[1], typeSnack: 'error');
    }
    prodProvider.isLoading = false;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _init();
    });
  }

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

    if (productProvider.isEdit && !productProvider.isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            'Editar Producto',
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
    } else if (!productProvider.isEdit && !productProvider.isLoading) {
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
        body: Column(mainAxisSize: MainAxisSize.max, children: [
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    dataViewWidget(
                        context: context,
                        labelField: 'Nombre de Producto',
                        valueField: productProvider.detailProduct.name!),
                    const SizedBox(
                      height: 20.0,
                    ),
                    dataViewWidget(
                        context: context,
                        labelField: 'Piezas en Stock',
                        valueField:
                            productProvider.detailProduct.pieces.toString()),
                    const SizedBox(
                      height: 20.0,
                    ),
                    dataViewWidget(
                        context: context,
                        labelField: 'Precio de Producto',
                        valueField:
                            productProvider.detailProduct.price.toString()),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ],
                )),
          ),
          const Spacer(),
          ButtonPrimary(textButton: 'Editar', actionButton: () async {}),
        ]),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          child: AdWidget(ad: myBanner),
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
        ),
      );
    }
    return const ShimmerProduct();
  }
}
