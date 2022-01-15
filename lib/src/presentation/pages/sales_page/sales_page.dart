import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/sales_page/sales_provider.dart';
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

class _Body extends StatelessWidget {
  _Body({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SalesProvider>(context);

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
      body: Builder(builder: (_) {
        if (provider.sales.length == 0) {
          return Center(
              child: Column(
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
            ],
          ));
        }

        return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            itemCount: provider.sales.length,
            itemBuilder: (_, i) {
              return CardCustomPreview(
                title: provider.sales[i].productName!,
                subtitle: provider.sales[i].total.toString(),
                leadingText: provider.sales[i].pieces.toString(),
              );
            });
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
