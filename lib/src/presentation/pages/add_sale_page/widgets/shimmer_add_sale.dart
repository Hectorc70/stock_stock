import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/simmer_widgets.dart';


class AddShimmerSale extends StatelessWidget {
  const AddShimmerSale({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          ' Venta',
          style: Theme.of(context).textTheme.headline6,
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 30.0,
              color: Theme.of(context).colorScheme.secondary,
            )),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          itemCount: 5,
          itemBuilder: (_, i) {
            return Column(
              children: const [
                ShimmerCustom.rectangular(height: 40.0),
                SizedBox(
                  height: 20.0,
                )
              ],
            );
          }),
    );
  }
}
