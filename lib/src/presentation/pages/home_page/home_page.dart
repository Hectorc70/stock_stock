import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/models/sale/sale_model.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/home_page/home_provider.dart';
import 'package:stock_stock/src/presentation/providers/nav_ui.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/bottom_nav.dart';
import 'package:stock_stock/src/presentation/widgets/card_data.dart';
import 'package:stock_stock/src/presentation/widgets/drawer_menu.dart';
import 'package:stock_stock/src/presentation/widgets/floatButton_bar.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';
import 'package:stock_stock/src/presentation/pages/home_page/widgets/card_mount_sale.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _init() async {
    final provider = Provider.of<HomeProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    provider.isLoading = true;
    final result = await provider.repositoryInterface
        .getSalesForDate(idShop: userProvider.selectShop, date: provider.date);
    provider.isLoading = false;
    if (result[0] == 200) {
      provider.totalToday = result[2];
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
    final userProvider = Provider.of<UserProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;
    final homeProvider = Provider.of<HomeProvider>(context);
    final uiProvider = Provider.of<UiProvider>(
      context,
    );
    final BannerAd myBanner = BannerAd(
      adUnitId: idBanner,
      size: AdSize.fullBanner,
      request: AdRequest(),
      listener: BannerAdListener(),
    );
    myBanner.load();
    return WillPopScope(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: drawerMenu(context: context),
          appBar: AppBar(
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
          body: RefreshIndicator(
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.only(left: 30.0),
                      width: widthScreen * 0.80,
                      child: Text(
                        'Hola ${userProvider.dataUser.username}, Bienvenido',
                        style: Theme.of(context).textTheme.headline5,
                      )),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: cardSaleToday(
                          context: context,
                          homeProvider: homeProvider,
                          date: homeProvider.date.toString(),
                          total: homeProvider.totalToday.toString())),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Expanded(
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          itemCount: homeProvider.sales.length,
                          itemBuilder: (_, i) {
                            return CardCustomPreview(
                              actionCard: () {
                                uiProvider.idSaleSelect =
                                    homeProvider.sales[i].id!;
                                Navigator.of(context).pushNamed('salePage');
                              },
                              title: homeProvider.sales[i].productName!,
                              subtitle: homeProvider.sales[i].total.toString(),
                              leadingText:
                                  homeProvider.sales[i].pieces.toString(),
                            );
                          })),
                  Container(
                    alignment: Alignment.center,
                    child: AdWidget(ad: myBanner),
                    width: myBanner.size.width.toDouble(),
                    height: myBanner.size.height.toDouble(),
                  )
                ],
              ),
              onRefresh: () async {
                final resp = await homeProvider.repositoryInterface
                    .getSalesForDate(
                        idShop: userProvider.selectShop,
                        date: homeProvider.date);

                if (resp[0] == 200) {
                  homeProvider.totalToday = resp[2];
                  homeProvider.sales = resp[1];
                } else {
                  homeProvider.repositoryInterface.showSnack(
                      context: context,
                      textMessage: resp[1],
                      typeSnack: 'error');
                }
              }),
          floatingActionButton: floatButtonNavBar(
              actionButton: () {
                Navigator.of(context).pushNamed('addSalePage');
              },
              context: context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigatorCustomBar(),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }
}
