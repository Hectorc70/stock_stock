import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
        providers: [],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: getApplicationRoutes(),
          theme: ThemeData(
              colorScheme: ColorScheme(
                  primary: const Color(0xFF005D7D),
                  primaryVariant: const Color(0xFF005D7D),
                  secondary: const Color(0xFF0490BF),
                  secondaryVariant: const Color(0xFF0490BF),
                  surface: const Color(0x3A80AEBE),
                  background: Colors.white,
                  error: Colors.red.shade300,
                  onPrimary: Colors.white,
                  onSecondary: Colors.white,
                  onSurface: const Color(0x3A7FB3C5),
                  onBackground: const Color(0xFF0490BF),
                  onError: Colors.red.shade300,
                  brightness: Brightness.light),
              textTheme: const TextTheme(
                bodyText1: TextStyle(fontFamily: 'Poppins', fontSize: 15),
                bodyText2: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                subtitle1: TextStyle(fontFamily: 'Poppins', fontSize: 15),
                subtitle2: TextStyle(fontFamily: 'Poppins', fontSize: 13),
                headline6: TextStyle(fontFamily: 'Poppins', fontSize: 19),
                headline5: TextStyle(fontFamily: 'Poppins', fontSize: 23),
              )),
        ));
  }
}
