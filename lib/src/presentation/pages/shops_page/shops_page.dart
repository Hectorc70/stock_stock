import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/shops_page/shops_provider.dart';
import 'package:stock_stock/src/presentation/pages/shops_page/widgets/card_shop.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/bottom_nav.dart';
import 'package:stock_stock/src/presentation/widgets/drawer_menu.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

class ShopsPage extends StatelessWidget {
  const ShopsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShopsProvider(
          repositoryInterface: context.read<RepositoryInterface>()),
      child: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  _Body({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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
          appBar: AppBar(
            title: Text(
              'Negocios',
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
          drawer: drawerMenu(context: context),
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    padding: const EdgeInsets.all(15.0),
                    itemCount: userProvider.dataUser.shops!.length,
                    itemBuilder: (_, i) {
                      if (userProvider.dataUser.shops!.length == 0) {
                        return Center(
                          child: Text('Sin Negocios'),
                        );
                      }

                      return cardShop(
                          context: context,
                          nameShop:
                              userProvider.dataUser.shops![i].split(':')[1]);
                    }),
              ),
              Container(
                alignment: Alignment.center,
                child: AdWidget(ad: myBanner),
                width: myBanner.size.width.toDouble(),
                height: myBanner.size.height.toDouble(),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigatorCustomBar(),
        ),
        onWillPop: () {
          return Future(() => false);
        });
  }
}
