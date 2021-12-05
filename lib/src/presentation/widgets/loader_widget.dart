import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

loaderView(BuildContext context) {
  final colorP = Theme.of(context).colorScheme.secondary;
  Loader.show(context,
      overlayColor: Color.fromRGBO(248, 249, 249, 250),
      isAppbarOverlay: true,
      isBottomBarOverlay: true,
      progressIndicator: CircularProgressIndicator(
        strokeWidth: 7.0,
        color: colorP,
      ));
}
