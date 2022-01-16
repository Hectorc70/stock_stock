import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/simmer_widgets.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

class ShimmerSales extends StatelessWidget {
  const ShimmerSales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ventas',
          style: Theme.of(context).textTheme.headline5,
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
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
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          itemCount: 5,
          itemBuilder: (_, i) {
            return Column(
              children: const [
                ShimmerCustom.rectangular(height: 80.0),
                SizedBox(
                  height: 10.0,
                )
              ],
            );
          }),
    );
  }
}
