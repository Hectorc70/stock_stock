import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/data/repository/remote/product/product.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/products_page/products_provider.dart';
import 'package:stock_stock/src/presentation/products_page/widgets/shimmer_products_page.dart';
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
    if (provider.isLoading) {
      return const ProductsLoader();
    }
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
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          itemCount: provider.products.length,
          itemBuilder: (_, i) {
            return CardCustomPreview(
              title: provider.products[i].name!,
              subtitle: provider.products[i].price.toString(),
              leadingText: provider.products[i].pieces.toString(),
            );
          }),
      bottomNavigationBar: const BottomNavigatorCustomBar(),
      floatingActionButton:
          floatButtonNavBar(actionButton: () {}, context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
