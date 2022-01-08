import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/drawer_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawerMenu(context: context),
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
            leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              size: 40.0,
              color: Theme.of(context).colorScheme.primary,
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
