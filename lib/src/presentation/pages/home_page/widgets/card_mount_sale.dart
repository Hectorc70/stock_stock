import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_stock/src/presentation/pages/home_page/home_provider.dart';
import 'package:stock_stock/src/presentation/providers/user_provider.dart';
import 'package:stock_stock/src/presentation/widgets/picker_calendar.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

Widget cardSaleToday({
  required BuildContext context,
  required String date,
  required String total,
  required HomeProvider homeProvider,
}) {
  Color shadowColor = const Color(0x82043A4D);
  final widthScreen = MediaQuery.of(context).size.width;
  final userProvider = Provider.of<UserProvider>(context, listen: false);
  return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
            BoxShadow(color: shadowColor, blurRadius: 10.0, spreadRadius: 0)
          ]),
      child: Card(
        color: Theme.of(context).colorScheme.primary,
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Total Vendido:',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontFamily: 'PoppinsBold',
                        fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0XFF247996)),
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    width: widthScreen * 0.43,
                    height: 35.0,
                    child: Row(
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              fontSize: 16.0,
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                            onTap: () async {
                              final resp =
                                  await showCustomCalendar(context: context);
                              homeProvider.date = resp.toString().split(' ')[0];

                              final respData = await homeProvider
                                  .repositoryInterface
                                  .getSalesForDate(
                                      idShop: userProvider.selectShop,
                                      date: homeProvider.date);

                              if (respData[0] == 200) {
                                homeProvider.totalToday = respData[2];
                                homeProvider.sales = respData[1];
                              } else {
                                homeProvider.repositoryInterface.showSnack(
                                    context: context,
                                    textMessage: respData[1],
                                    typeSnack: 'error');
                              }
                            },
                            child: Icon(
                              StockIcons.calendar,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ))
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '\$ $total MXN',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontFamily: 'PoppinsBold',
                        fontSize: 30),
                  ),
                ],
              )
            ],
          ),
        ),
      ));
}
