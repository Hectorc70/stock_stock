import 'dart:ui';

import 'package:flutter/material.dart';

class ButtonPrimary extends StatelessWidget {
  String textButton = '';
  final VoidCallback actionButton;
  double widthButton;
  ButtonPrimary(
      {required this.textButton,
      required this.actionButton,
      this.widthButton = double.infinity,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: actionButton,
      child: Container(
        alignment: AlignmentDirectional.center,
        width: widthButton,
        height: 55.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1.0, blurRadius: 10.0, color: Color(0x70043A4D))
          ],
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Text(
          textButton,
          style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontFamily: 'PoppinsSemiBold'),
        ),
      ),
    );
  }
}

class ButtonSecond extends StatelessWidget {
  String textButton = '';
  final VoidCallback actionButton;
  double widthButton;
  ButtonSecond(
      {required this.textButton,
      required this.actionButton,
      this.widthButton = double.infinity,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: actionButton,
      child: Container(
        alignment: AlignmentDirectional.center,
        width: widthButton,
        height: 55.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          boxShadow: [
            BoxShadow(
                spreadRadius: 1.0, blurRadius: 10.0, color: Color(0x70043A4D))
          ],
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: Text(
          textButton,
          style: TextStyle(
              color: Colors.white,
              fontSize: 26.0,
              fontFamily: 'PoppinsSemiBold'),
        ),
      ),
    );
  }
}
