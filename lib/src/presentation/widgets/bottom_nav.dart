import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/presentation/providers/nav_ui.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

class BottomNavigatorCustomBar extends StatelessWidget {
  const BottomNavigatorCustomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiprovider = Provider.of<UiProvider>(context);
    int indexSelect = uiprovider.selectOption;
    return Container(
        decoration:
            BoxDecoration(color: Theme.of(context).colorScheme.background),
        height: 60.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.grey,
          currentIndex: indexSelect,
          onTap: (index) async {
            if (index == 0 && uiprovider.selectOption != index) {
              uiprovider.selectOption = index;
              Navigator.of(context).pushNamed('homePage');
            } else if (index == 1 && uiprovider.selectOption != index) {
              uiprovider.selectOption = index;
              Navigator.of(context).pushNamed('salesPage');
            } else if (index == 2 && uiprovider.selectOption != index) {
              uiprovider.selectOption = index;
              Navigator.of(context).pushNamed('productsPage');
            } else if (index == 3 && uiprovider.selectOption != index) {
              uiprovider.selectOption = index;
              Navigator.of(context).pushNamed('shopsPage');
            }
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  StockIcons.homepage,
                ),
                label: 'Inicio'),
            BottomNavigationBarItem(
                icon: Icon(
                  StockIcons.sales,
                ),
                label: 'Ventas'),
            BottomNavigationBarItem(
                icon: Icon(
                  StockIcons.stock,
                ),
                label: 'Almacen'),
            BottomNavigationBarItem(
                icon: Icon(
                  StockIcons.market,
                ),
                label: 'Negocios'),
          ],
        ));
  }
}
