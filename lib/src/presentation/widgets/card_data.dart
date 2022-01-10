import 'package:flutter/material.dart';
import 'package:stock_stock/src/data/repository/local/utils.dart';

class CardCustomPreview extends StatelessWidget {
  String title;
  String subtitle;
  String leadingText;

  CardCustomPreview(
      {required this.title,
      required this.subtitle,
      required this.leadingText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    leadingText = textLimit(leadingText, 4);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).colorScheme.surface,
      ),
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        elevation: 0.0,
        color: Theme.of(context).colorScheme.surface,
        child: ListTile(
          leading: Container(
            alignment: AlignmentDirectional.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color(0XFFCCE1E9)),
            height: 40.0,
            width: 70.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              'X $leadingText',
              style: TextStyle(
                  fontFamily: 'PoppinsBold',
                  color: Color(0XFF5F90A1),
                  fontSize: 16.0),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface, fontSize: 20.0),
          ),
          subtitle: Text(
            '\$ $subtitle',
            style: TextStyle(
                fontFamily: 'PoppinsBold',
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 20.0),
          ),
          trailing: Icon(Icons.arrow_forward_ios_rounded, color:Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
