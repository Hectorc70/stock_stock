import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/bottom_nav.dart';
import 'package:stock_stock/src/presentation/widgets/drawer_menu.dart';
import 'package:stock_stock/src/presentation/widgets/floatButton_bar.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';
import 'package:stock_stock/src/presentation/pages/home_page/widgets/card_mount_sale.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                  child: cardSaleToday(context: context)),
              const Spacer(),
              Container(
                alignment: Alignment.center,
                child: AdWidget(ad: myBanner),
                width: myBanner.size.width.toDouble(),
                height: myBanner.size.height.toDouble(),
              )
            ],
          ),
          floatingActionButton:
              floatButtonNavBar(actionButton: () {}, context: context),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigatorCustomBar(),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }
}
