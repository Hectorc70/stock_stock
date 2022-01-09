import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/drawer_menu.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
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
              size: 35.0,
              color: Theme.of(context).colorScheme.secondary,
            )),
        actions: [
          TextButton(
              onPressed: () {},
              child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://i.stack.imgur.com/l60Hf.png'),
                          fit: BoxFit.cover))))
        ],
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
