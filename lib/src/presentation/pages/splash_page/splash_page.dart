import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/domain/constants/assets_constants.dart';
import 'package:stock_stock/src/domain/repository/repository_interface.dart';
import 'package:stock_stock/src/presentation/pages/splash_page/splash_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SplashProvider(
          repositoryInterface: context.read<RepositoryInterface>()),
      builder: (_, __) {
        return const SplashPage();
      },
    );
  }

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void _init() async {
    final provider = context.read<SplashProvider>();
    final result = await provider.loadData();

    if (result) {
      Navigator.of(context).pushReplacementNamed('homePage');
    } else {
      Navigator.of(context).pushReplacementNamed('loginPage');
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
