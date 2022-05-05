import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/core/constants/constants.dart';
import 'package:stock_stock/src/domain/models/sale/sale_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/add_sale_page/add_sale_provider.dart';
import 'package:stock_stock/src/presentation/pages/add_sale_page/widgets/shimmer_add_sale.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';
import 'package:stock_stock/src/presentation/widgets/loader_widget.dart';
import 'package:stock_stock/src/presentation/widgets/messages_popup.dart';

class AddSalePage extends StatelessWidget {
  const AddSalePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddSaleProvider(
          repositoryInterface: context.read<RepositoryInterface>()),
      builder: (_, __) {
        return _Body();
      },
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPieces = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerTotal = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _init() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final saleProvider = Provider.of<AddSaleProvider>(context, listen: false);

    if (userProvider.productsItemsSelect.length == 0) {
      saleProvider.isLoading = true;
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final saleProvider = Provider.of<AddSaleProvider>(context, listen: false);

    if (saleProvider.isLoading) {
      return AddShimmerSale();
    }

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
          'Crear Venta',
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
                      .createSale(
                          model: SaleModel(
                              pieces: int.parse(controllerPieces.text),
                              productId: int.parse(controllerName.text),
                              total: double.parse(controllerTotal.text),
                              username: userProvider.dataUser.username,
                              emailUser: userProvider.dataUser.email));

                  Loader.hide();
                  if (resp[0] == 201) {
                    messageThowOK(
                        context: context,
                        msg: 'Venta creada',
                        action: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamed('salesPage');
                        },
                        secondAction: () {
                          Navigator.of(context).pop();
                          _resetFields();
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
  }

  void _resetFields() {
    controllerName.text = '';
    controllerPieces.text = '1';
    controllerPrice.text = '';
    controllerTotal.text = '';
  }
}
