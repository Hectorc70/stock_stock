import 'package:flutter/material.dart';

Widget dataViewWidget(
    {required BuildContext context,
    required String labelField,
    required String valueField}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Icon(
            Icons.email_rounded,
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Text(
            labelField,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: 'PoppinsLight',
                fontSize: 18.0),
          ),
        ],
      ),
      Row(
        children: [
          const SizedBox(
            width: 35.0,
          ),
          Text(
            valueField == null ? '' : valueField,
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: 'PoppinsSemiBold',
                fontSize: 20.0),
          ),
        ],
      ),
      Divider(
        color: Theme.of(context).colorScheme.primary,
        height: 4.0,
        thickness: .8,
      )
    ],
  );
}
