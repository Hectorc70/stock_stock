import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/drawer_menu.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: Container(
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(left: 30.0),
                width: widthScreen * 0.80,
                child: Text(
                  'Hola ${userProvider.dataUser.username}, Bienvenido',
                  style: Theme.of(context).textTheme.headline5,
                ))
          ],
        ),
      ),
    );
  }
}
