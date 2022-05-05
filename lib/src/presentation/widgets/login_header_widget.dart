import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_stock/src/core/constants/assets_constants.dart';

Widget logoWidget() {
  return SafeArea(
      child: Container(
          width: double.infinity,
          height: 100.0,
          alignment: AlignmentDirectional.center,
          child: Image.asset(
            logoGreen,
          )));
}
