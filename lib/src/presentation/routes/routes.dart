import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/pages/home_page/home_page.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_page.dart';
import 'package:stock_stock/src/presentation/pages/new_shop_page/new_shop_page.dart';
import 'package:stock_stock/src/presentation/pages/product_form/product_page.dart';
import 'package:stock_stock/src/presentation/pages/products_page/products_page.dart';
import 'package:stock_stock/src/presentation/pages/register_page/register_page.dart';
import 'package:stock_stock/src/presentation/pages/shops_page/shops_page.dart';
import 'package:stock_stock/src/presentation/pages/splash_page/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes(BuildContext context) {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => SplashPage.init(context),
    'loginPage': (BuildContext context) => const LoginPage(),
    'registerPage': (BuildContext context) => const RegisterPage(),
    'homePage': (BuildContext context) => HomePage(),
    'newShopPage': (BuildContext context) => const NewShopPage(),
    'shopsPage': (BuildContext context) => const ShopsPage(),
    'productsPage': (BuildContext context) => ProductsPage.init(context),
    'productPage': (BuildContext context) => const ProductPage(),
  };
}
