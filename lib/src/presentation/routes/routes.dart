import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/pages/splash_page/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => SplashPage(),
  };
}
