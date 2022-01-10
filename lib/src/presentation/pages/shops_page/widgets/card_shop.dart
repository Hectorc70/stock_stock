import 'package:flutter/material.dart';

Widget cardShop({required BuildContext context, required String nameShop}) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20.0)),
    child: Card(
      elevation: 0.0,
      color: Theme.of(context).colorScheme.surface,
      child: ListTile(
        title: Text(
          nameShop,
          style: const TextStyle(
              fontSize: 20.0,
              fontFamily: 'PoppinsBold',
              color: Color(0xff7FB3C5)),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Color(0xff7FB3C5),
        ),
      ),
    ),
  );
}
