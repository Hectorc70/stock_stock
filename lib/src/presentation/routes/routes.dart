import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/pages/home_page/home_page.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_page.dart';
import 'package:stock_stock/src/presentation/pages/register_page/register_page.dart';
import 'package:stock_stock/src/presentation/pages/splash_page/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(BuildContext context) {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => SplashPage.init(context),
    'loginPage': (BuildContext context) => const LoginPage(),
    'registerPage': (BuildContext context) => const RegisterPage(),
    'homePage': (BuildContext context) =>  HomePage(),
  };
}
