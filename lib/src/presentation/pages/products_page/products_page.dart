import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/core/constants/constants.dart';
import 'package:stock_stock/src/data/repository/remote/product/product.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/products_page/products_provider.dart';
import 'package:stock_stock/src/presentation/pages/products_page/widgets/shimmer_products_page.dart';
import 'package:stock_stock/src/presentation/providers/nav_ui.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/bottom_nav.dart';
import 'package:stock_stock/src/presentation/widgets/card_data.dart';
import 'package:stock_stock/src/presentation/widgets/drawer_menu.dart';
import 'package:stock_stock/src/presentation/widgets/floatButton_bar.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProductsProvider(
          repositoryInterface: context.read<RepositoryInterface>()),
      builder: (_, __) {
        return ProductsPage._();
      },
    );
  }

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void _init() async {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    provider.isLoading = true;
    final result =
        await ApiProduct().getProducts(idShop: userProvider.selectShop);
    provider.isLoading = false;
    if (result[0] == 200) {
      provider.products = result[1];
      userProvider.productsItemsSelect = result[2];
      userProvider.productsMapSelect = result[3];
    } else {
      provider.repositoryInterface.showSnack(
          context: context, textMessage: result[1], typeSnack: 'error');
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context);
    final userProvider = Provider.of<UserProvider>(
      context,
    );
    final uiProvider = Provider.of<UiProvider>(
      context,
    );
    if (provider.isLoading) {
      return const ProductsLoader();
    }

    final BannerAd myBanner = BannerAd(
      adUnitId: idBanner,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();
    return Scaffold(
      key: _scaffoldKey,
      drawer: drawerMenu(context: context),
      appBar: AppBar(
        title: Text(
          'Productos',
          style: Theme.of(context).textTheme.headline5,
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            icon: Icon(
              StockIcons.menu,
              size: 30.0,
              color: Theme.of(context).colorScheme.secondary,
            )),
        actions: [
          TextButton(
              onPressed: () {},
              child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          fit: BoxFit.cover))))
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: RefreshIndicator(child: Builder(builder: (_) {
        if (provider.products.length == 0) {
          return Center(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sin productos',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Crea uno',
                style: Theme.of(context).textTheme.headline6,
              ),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: AdWidget(ad: myBanner),
                width: myBanner.size.width.toDouble(),
                height: myBanner.size.height.toDouble(),
              )
            ],
          ));
        }

        return Column(
          children: [
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    itemCount: provider.products.length,
                    itemBuilder: (_, i) {
                      return CardCustomPreview(
                        actionCard: () {
                          uiProvider.idProductSelect = provider.products[i].id!;
                          Navigator.of(context).pushNamed('productPage');
                        },
                        title: provider.products[i].name!,
                        subtitle: provider.products[i].price.toString(),
                        leadingText: provider.products[i].pieces.toString(),
                      );
                    })),
            Container(
              alignment: Alignment.center,
              child: AdWidget(ad: myBanner),
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
            )
          ],
        );
      }), onRefresh: () async {
        final result = await provider.repositoryInterface
            .getProductsForShop(idShop: userProvider.selectShop);

        if (result[0] == 200) {
          provider.products = result[1];
          userProvider.productsItemsSelect = result[2];
          userProvider.productsMapSelect = result[3];
        } else {
          provider.repositoryInterface.showSnack(
              context: context, textMessage: result[1], typeSnack: 'error');
        }
      }),
      bottomNavigationBar: const BottomNavigatorCustomBar(),
      floatingActionButton: floatButtonNavBar(
          actionButton: () {
            Navigator.of(context).pushNamed('addProductPage');
          },
          context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
