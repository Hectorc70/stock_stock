import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/sales_page/sales_provider.dart';
import 'package:stock_stock/src/presentation/pages/sales_page/widgets/shimmer_sales.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/bottom_nav.dart';
import 'package:stock_stock/src/presentation/widgets/card_data.dart';
import 'package:stock_stock/src/presentation/widgets/drawer_menu.dart';
import 'package:stock_stock/src/presentation/widgets/floatButton_bar.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SalesProvider(
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
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _init() async {
    final provider = Provider.of<SalesProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    provider.isLoading = true;
    final result = await provider.repositoryInterface
        .getSalesForShop(idShop: userProvider.selectShop);
    provider.isLoading = false;
    if (result[0] == 200) {
      provider.sales = result[1];
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
    final provider = Provider.of<SalesProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (provider.isLoading) {
      return const ShimmerSales();
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
          'Ventas',
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
        if (provider.sales.length == 0) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sin Ventas',
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                'Crea una',
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
          );
        }

        return Column(
          children: [
            Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    itemCount: provider.sales.length,
                    itemBuilder: (_, i) {
                      return CardCustomPreview(
                        title: provider.sales[i].productName!,
                        subtitle: provider.sales[i].total.toString(),
                        leadingText: provider.sales[i].pieces.toString(),
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
            .getSalesForShop(idShop: userProvider.selectShop);

        if (result[0] == 200) {
          provider.sales = result[1];
        } else {
          provider.repositoryInterface.showSnack(
              context: context, textMessage: result[1], typeSnack: 'error');
        }
      }),
      bottomNavigationBar: const BottomNavigatorCustomBar(),
      floatingActionButton: floatButtonNavBar(
          actionButton: () {
            Navigator.of(context).pushNamed('salePage');
          },
          context: context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
