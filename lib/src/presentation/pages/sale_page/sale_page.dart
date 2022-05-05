import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/core/constants/constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/sale_page/sale_provider.dart';
import 'package:stock_stock/src/presentation/pages/sale_page/widgets/sale_shimmer.dart';
import 'package:stock_stock/src/presentation/providers/nav_ui.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/loader_widget.dart';
import 'package:stock_stock/src/presentation/widgets/messages_popup.dart';
import 'package:stock_stock/src/presentation/widgets/view_data_widget.dart';

class SalePage extends StatelessWidget {
  const SalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SaleProvider(
          repositoryInterface: context.read<RepositoryInterface>()),
      builder: (_, __) {
        return _Body();
      },
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
  TextEditingController controllerTotal = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _init() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final saleProvider = Provider.of<SaleProvider>(context, listen: false);
    final uiProvider = Provider.of<UiProvider>(context, listen: false);

    saleProvider.isLoading = true;
    final result = await saleProvider.repositoryInterface
        .getSaleForId(idSale: uiProvider.idSaleSelect.toString());

    if (result[0] == 200) {
      saleProvider.saleDetail = result[1];
      if (userProvider.productsItemsSelect.length == 0) {
        final result = await saleProvider.repositoryInterface
            .getProductsForShop(idShop: userProvider.selectShop);
        saleProvider.isLoading = false;
        if (result[0] == 200) {
          userProvider.productsItemsSelect = result[2];
          userProvider.productsMapSelect = result[3];
        } else {
          saleProvider.repositoryInterface.showSnack(
              context: context, textMessage: result[1], typeSnack: 'error');
        }
      }
      controllerPieces.text = '1';
    } else {
      Navigator.of(context).pop();
      saleProvider.repositoryInterface.showSnack(
          context: context, textMessage: result[1], typeSnack: 'error');
    }
    saleProvider.isLoading = false;
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
    controllerTotal.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final saleProvider = Provider.of<SaleProvider>(context);
    final uiProvider = Provider.of<UiProvider>(context);

    if (!saleProvider.isLoading && saleProvider.isEdit) {
      final BannerAd myBanner = BannerAd(
        adUnitId: idBanner,
        size: AdSize.fullBanner,
        request: AdRequest(),
        listener: BannerAdListener(),
      );
      myBanner.load();
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            'Editar Venta',
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
                        FieldSelectForm(
                            hintTextC: 'PPr',
                            labelTextInput: 'Producto',
                            controllerField: controllerName,
                            functionOnChanged: (value) {
                              if (value != null) {
                                controllerTotal.text = userProvider
                                    .productsMapSelect[value]!.price
                                    .toString();

                                controllerPrice.text = userProvider
                                    .productsMapSelect[value]!.price
                                    .toString();
                              }
                            },
                            items: userProvider.productsItemsSelect),
                        CustomFormField(
                            labelField: 'Precio de Producto',
                            hintField: 'ejemplo: 20.0',
                            isEnabled: false,
                            controller: controllerPrice),
                        CustomFormPiecesField(
                          labelField: 'Piezas de Producto',
                          hintField: 'ejemplo: 100',
                          controller: controllerPieces,
                          functionOnChanged: (value) {
                            if (value != '' && value != '0') {
                              final sum = int.parse(value) *
                                  double.parse(controllerPrice.text);

                              controllerTotal.text = sum.toString();
                            }
                          },
                        ),
                        CustomFormField(
                            labelField: 'Todal de Venta',
                            hintField: 'ejemplo: 20.0',
                            isEnabled: false,
                            controller: controllerTotal),
                      ],
                    )),
              ),
            ),
            const Spacer(),
            ButtonPrimary(
                textButton: 'Guardar',
                actionButton: () async {
                  if (_formKey.currentState!.validate()) {
                    loaderView(context);
                    final resp = await saleProvider.repositoryInterface
                        .updateSale(data: {
                      'product': controllerName.text,
                      'pieces': controllerPieces.text,
                      'total_sale': controllerTotal.text
                    }, idSale: uiProvider.idSaleSelect.toString());

                    Loader.hide();
                    if (resp[0] == 200) {
                      messageOK(
                          context: context,
                          msg: 'Venta Editada',
                          action: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed('salesPage');
                          });
                    } else if (resp[0] == 400) {
                      saleProvider.repositoryInterface.showSnack(
                          context: context,
                          textMessage: resp[1],
                          typeSnack: 'error');
                    } else {
                      saleProvider.repositoryInterface.showSnack(
                          context: context,
                          textMessage: resp[1],
                          typeSnack: 'error');
                    }
                  }
                }),
          ],
        ),
        bottomNavigationBar: Container(
          alignment: Alignment.center,
          child: AdWidget(ad: myBanner),
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
        ),
      );
    } else if (!saleProvider.isLoading && !saleProvider.isEdit) {
      final BannerAd myBanner = BannerAd(
        adUnitId: idBanner,
        size: AdSize.fullBanner,
        request: AdRequest(),
        listener: BannerAdListener(),
      );
      myBanner.load();
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text(
            'Detalle de Venta',
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
                child: Column(
                      children: [
                        const SizedBox(
                          height: 10.0,
                        ),
                        dataViewWidget(
                            context: context,
                            labelField: 'Nombre de Producto',
                            valueField: saleProvider.saleDetail.productName
                                .toString()
                                .toString()),
                        const SizedBox(
                          height: 20.0,
                        ),
                        dataViewWidget(
                            context: context,
                            labelField: 'Piezas Vendidas',
                            valueField:
                                saleProvider.saleDetail.pieces!.toString()),
                        const SizedBox(
                          height: 20.0,
                        ),
                        dataViewWidget(
                            context: context,
                            labelField: 'Total de Venta',
                            valueField:
                                saleProvider.saleDetail.total!.toString()),
                        const SizedBox(
                          height: 20.0,
                        ),
                        dataViewWidget(
                            context: context,
                            labelField: 'Fecha de Venta',
                            valueField: saleProvider.saleDetail.dateSale!),
                        const SizedBox(
                          height: 20.0,
                        ),
                        dataViewWidget(
                            context: context,
                            labelField: 'Hora de Venta',
                            valueField: saleProvider.saleDetail.timeSale!),
                        const SizedBox(
                          height: 20.0,
                        ),
                        dataViewWidget(
                            context: context,
                            labelField: 'Vendido Por',
                            valueField: saleProvider.saleDetail.username!)
                      ],
                    )),
            
            ),
            const Spacer(),
            ButtonPrimary(
                textButton: 'Editar',
                actionButton: () async {
                  controllerName.text =
                      saleProvider.saleDetail.productId.toString();

                  controllerPrice.text =
                      saleProvider.saleDetail.productPrice.toString();
                  controllerPieces.text =
                      saleProvider.saleDetail.pieces.toString();
                  controllerTotal.text =
                      saleProvider.saleDetail.total.toString();

                  saleProvider.isEdit = true;
                }),
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
    return ShimmerSale();
  }
}
