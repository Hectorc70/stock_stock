import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/pages/add_product_page/add_product_page.dart';
import 'package:stock_stock/src/presentation/pages/add_sale_page/add_sale_page.dart';
import 'package:stock_stock/src/presentation/pages/home_page/home_page.dart';
import 'package:stock_stock/src/presentation/pages/login_page/login_page.dart';
import 'package:stock_stock/src/presentation/pages/new_shop_page/new_shop_page.dart';
import 'package:stock_stock/src/presentation/pages/product_page/product_page.dart';
import 'package:stock_stock/src/presentation/pages/products_page/products_page.dart';
import 'package:stock_stock/src/presentation/pages/register_page/register_page.dart';
import 'package:stock_stock/src/presentation/pages/sale_page/sale_page.dart';
import 'package:stock_stock/src/presentation/pages/sales_page/sales_page.dart';
import 'package:stock_stock/src/presentation/pages/shops_page/shops_page.dart';
import 'package:stock_stock/src/presentation/pages/splash_page/splash_page.dart';

const splashPage = '/';
const loginPage = 'loginPage';
const registerPage = 'registerPage';
const homePage = 'homePage';
const newShopPage = 'newShopPage';
const shopsPage = 'shopsPage';
const productsPage = 'productsPage';
const productPage = 'productPage';
const addProductPage = 'addProductPage';
const salesPage = 'salesPage';
const salePage = 'salePage';
const addSalePage = 'addSalePage';

Map<String, WidgetBuilder> getApplicationRoutes(BuildContext context) {
  return <String, WidgetBuilder>{
    splashPage: (BuildContext context) => SplashPage(),
    loginPage: (BuildContext context) => const LoginPage(),
    registerPage: (BuildContext context) => const RegisterPage(),
    homePage: (BuildContext context) => HomePage(),
    newShopPage: (BuildContext context) => const NewShopPage(),
    shopsPage: (BuildContext context) => const ShopsPage(),
    productsPage: (BuildContext context) => ProductsPage.init(context),
    productPage: (BuildContext context) => const ProductPage(),
    addProductPage: (BuildContext context) => const AddProductPage(),
    salesPage: (BuildContext context) => const SalesPage(),
    salePage: (BuildContext context) => const SalePage(),
    addSalePage: (BuildContext context) => const AddSalePage()
  };
}
