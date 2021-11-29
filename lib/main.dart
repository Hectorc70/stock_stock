import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/routes/routes.dart';
import 'package:provider/provider.dart';

void main() async {
  //await NotificationServiceLocal().init();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: getApplicationRoutes(),
        ));
  }
}
