import 'package:flutter/material.dart';

Widget googleButton({required final VoidCallback action}) {
  return GestureDetector(
      onTap: action,
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 10.0, spreadRadius: 1.0, color: Color(0x25043A4D))
        ], shape: BoxShape.circle, color: Colors.white),
        padding: const EdgeInsets.all(10.0),
        child: Image.asset('assets/images/logo_google.png'),
      ));
}
