import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/simmer_widgets.dart';

class ProductsLoader extends StatelessWidget {
  const ProductsLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          const ShimmerCustom.rectangular(
            height: 80.0,
            width: double.infinity,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (_, i) {
                    return Column(
                      children: const [
                        ShimmerCustom.rectangular(
                          height: 80.0,
                          width: double.infinity,
                        ),
                        SizedBox(
                          height: 10.0,
                        )
                      ],
                    );
                  })),
        ],
      ),
    );
  }
}
