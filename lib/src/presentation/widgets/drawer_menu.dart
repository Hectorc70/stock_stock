import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/login_header_widget.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

Widget drawerMenu({required BuildContext context}) {
  final widthScreen = MediaQuery.of(context).size.width;
  return Drawer(
      child: SafeArea(
    child: Column(
      children: [
        logoWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: widthScreen * .34,
              color: Theme.of(context).colorScheme.primary,
              height: 2,
            ),
            Text(
              ' ',
              style: Theme.of(context).textTheme.headline5,
            ),
            Container(
              width: widthScreen * .34,
              color: Theme.of(context).colorScheme.primary,
              height: 2,
            )
          ],
        ),
        const SizedBox(
          height: 30.0,
        ),
        Expanded(
            child: SingleChildScrollView(
                child: Column(
          children: [
            Container(
                color: Theme.of(context).colorScheme.onSurface,
                child: ListTile(
                  leading: Icon(
                    StockIcons.export_icon,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Exportar Datos',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onTap: () {},
                )),
            const SizedBox(
              height: 20.0,
            ),
            Container(
                color: Theme.of(context).colorScheme.onSurface,
                child: ListTile(
                  leading: Icon(
                    StockIcons.market,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Negocios',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onTap: () {},
                )),
            const SizedBox(
              height: 20.0,
            ),
            Container(
                color: Theme.of(context).colorScheme.onSurface,
                child: ListTile(
                  leading: Icon(
                    StockIcons.programming,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Desarrollador',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onTap: () {},
                )),
            const SizedBox(
              height: 20.0,
            ),
            Container(
                color: Theme.of(context).colorScheme.onSurface,
                child: ListTile(
                  leading: Icon(
                    StockIcons.logout,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  title: Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  onTap: () {},
                ))
          ],
        )))
      ],
    ),
  ));
}
