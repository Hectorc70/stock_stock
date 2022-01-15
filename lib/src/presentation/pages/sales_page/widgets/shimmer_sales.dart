import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/simmer_widgets.dart';

class ShimmerSales extends StatelessWidget {
  const ShimmerSales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView.builder(
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
