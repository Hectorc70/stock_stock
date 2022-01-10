import 'package:flutter/material.dart';
import 'package:stock_stock/src/presentation/widgets/stock_icons_icons.dart';

Widget cardSaleToday({
  required BuildContext context,
}) {
  Color shadowColor = const Color(0x82043A4D);
  final widthScreen = MediaQuery.of(context).size.width;
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
                          'OCT/22/2021',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        const Expanded(child: SizedBox()),
                        GestureDetector(
                            onTap: () {},
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
                    '\$ 30.00 MXN',
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
