import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_stock/src/core/constants/assets_constants.dart';
import 'package:stock_stock/src/presentation/pages/splash_page/splash_provider.dart';

class SplashPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _splashProvider = ref.read(splashProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Image.asset(
          logoWhite,
          width: 140.0,
          height: 140.0,
        ),
      ),
    );
  }
}
