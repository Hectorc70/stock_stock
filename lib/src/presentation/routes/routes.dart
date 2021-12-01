import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_page.dart';
import 'package:stock_stock/src/presentation/pages/splash_page/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const SplashPage(),
    'login/': (BuildContext context) => const LoginPage(),
  };
}
