import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

Widget googleButton({required final VoidCallback action}) {
  return GestureDetector(
      onTap: action,
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 10.0, spreadRadius: 1.0, color: Color(0x25043A4D))
        ], shape: BoxShape.circle, color: Colors.white),
        padding: const EdgeInsets.all(10.0),
        child: Image.asset('assets/images/logo_google.png'),
      ));
}

Widget emailButton(
    {required final BuildContext context, required final VoidCallback action}) {
  return GestureDetector(
      onTap: action,
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                  color: Theme.of(context).colorScheme.shadow)
            ],
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.background),
        padding: const EdgeInsets.all(10.0),
        child: Icon(
          StockIcons.correo,
          size: 40.0,
          color: Theme.of(context).colorScheme.primary,
        ),
      ));
}
