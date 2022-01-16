import 'package:flutter/material.dart';

Widget floatButtonNavBar(
    {required BuildContext context, required final VoidCallback actionButton}) {
  return GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: actionButton,
    child: Container(
      width: 50.0,
      height: 50.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Theme.of(context).colorScheme.primary),
      child: Icon(Icons.add_rounded,
          color: Theme.of(context).colorScheme.onPrimary),
    ),
  );
}
