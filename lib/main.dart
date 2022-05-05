import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stock_stock/src/data/repository/local/local_notifications.dart';
import 'package:stock_stock/src/data/repository/local/preferences_user.dart';
import 'package:stock_stock/src/data/repository/local/push_notifications.dart';
import 'package:stock_stock/src/presentation/routes/routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  //await NotificationServiceLocal().init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  await PreferencesUser().initiPrefs();
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: ['57427CEC31515F00F5DB03F1B5D94FC5']);
  MobileAds.instance.updateRequestConfiguration(configuration);
  await PushNotificationsService.initializeApp();
  LocalNotifications.initializeApp();
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
    return Builder(builder: (newcontext) {
      return ProviderScope(
          child: MaterialApp(
        navigatorKey: navigatorKey, //navegar
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es'),
        ],
        debugShowCheckedModeBanner: false,
        routes: getApplicationRoutes(newcontext),
        theme: ThemeData(
            colorScheme: ColorScheme(
                primary: const Color(0xFF005D7D),
                secondary: const Color(0xFF0490BF),
                surface: const Color(0xFFEDFAFF),
                shadow: const Color(0x25043A4D),
                
                background: Colors.white,
                error: Colors.red.shade300,
                onPrimary: Colors.white,
                onSecondary: Colors.white,
                onSurface: const Color(0xFF7FB3C5),
                onBackground: const Color(0xFF0490BF),
                onError: Colors.red.shade300,
                brightness: Brightness.light),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Color(0xFF0490BF),
              ),
              bodyText2: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 13,
                color: Color(0xFF0490BF),
              ),
              subtitle1: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
                color: Color(0xFF0490BF),
              ),
              subtitle2: TextStyle(fontFamily: 'Poppins', fontSize: 13),
              headline6: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 19,
                color: Color(0xFF0490BF),
              ),
              headline5: TextStyle(
                fontFamily: 'PoppinsBold',
                fontSize: 23,
                color: Color(0xFF0490BF),
              ),
            )),
      ));
    });
  }
}
