import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/sale_page/sale_provider.dart';
import 'package:stock_stock/src/presentation/widgets/button_primary.dart';
import 'package:stock_stock/src/presentation/widgets/fields_widget.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                      CustomFormField(
                          labelField: 'Producto',
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
              textButton: 'Guardar',
              actionButton: () async {
                if (_formKey.currentState!.validate()) {}
              }),
          const SizedBox(
            height: 10.0,
          ),
          /*  ButtonSecond(
              textButton: 'Agregar ',
              actionButton: () async {
                if (_formKey.currentState!.validate()) {}
              }) */
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
}
