import 'dart:ui';

import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  String labelField = '';
  String hintField = '';

  double widthField;

  CustomFormField(
      {required this.labelField,
      required this.hintField,
      this.widthField = double.maxFinite,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorSecond = Theme.of(context).colorScheme.secondary;
    return Container(
      width: widthField,
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelField,
            style: TextStyle(
                color: colorSecond, fontFamily: 'PoppinsLight', fontSize: 18.0),
          ),
          TextFormField(
            style: const TextStyle(
                color: Color(0xFF7FB3C5), fontFamily: 'Poppins'),
            decoration: InputDecoration(
                hintText: hintField,
                hintStyle: const TextStyle(
                    color: Color(0xFF7FB3C5), fontFamily: 'Poppins'),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                filled: true,
                isDense: true,
                fillColor: const Color(0xFFF8FDFF),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 2.0, color: colorSecond)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colorSecond)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colorSecond))),
            validator: (value) {
              if (value == '' || value == null) {
                return 'Este campo es requerido';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class CustomFormEmailField extends StatelessWidget {
  String labelField = '';
  double widthField;

  CustomFormEmailField(
      {required this.labelField, this.widthField = double.maxFinite, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validCharacters = RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,}$');
    Color colorSecond = Theme.of(context).colorScheme.secondary;
    return Container(
      width: widthField,
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelField,
            style: TextStyle(
                color: colorSecond, fontFamily: 'PoppinsLight', fontSize: 18.0),
          ),
          TextFormField(
            style: const TextStyle(
                color: Color(0xFF7FB3C5), fontFamily: 'Poppins'),
            decoration: InputDecoration(
                hintText: 'ejemplo@gmail.com',
                hintStyle: const TextStyle(
                    color: Color(0xFF7FB3C5), fontFamily: 'Poppins'),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                filled: true,
                isDense: true,
                fillColor: const Color(0xFFF8FDFF),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 2.0, color: colorSecond)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colorSecond)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colorSecond))),
            validator: (value) {
              final resp = validCharacters.hasMatch(value.toString());
              if (value == '' || value == null) {
                return 'Este campo es requerido';
              } else if (!resp) {
                return 'Email Invalido';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class CustomFormPasswordField extends StatelessWidget {
  String labelField = '';
  double widthField;

  CustomFormPasswordField(
      {required this.labelField, this.widthField = double.maxFinite, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final validCharacters = RegExp(r'^(?=\S+$)');
    Color colorSecond = Theme.of(context).colorScheme.secondary;
    return Container(
      width: widthField,
      margin: const EdgeInsets.only(top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelField,
            style: TextStyle(
                color: colorSecond, fontFamily: 'PoppinsLight', fontSize: 18.0),
          ),
          TextFormField(
            style: TextStyle(color: Color(0xFF7FB3C5), fontFamily: 'Poppins'),
            obscureText: true,
            decoration: InputDecoration(
                hintText: '*******',
                hintStyle: const TextStyle(
                    color: Color(0xFF7FB3C5), fontFamily: 'Poppins'),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                filled: true,
                isDense: true,
                fillColor: const Color(0xFFF8FDFF),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 2.0, color: colorSecond)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colorSecond)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colorSecond))),
            validator: (value) {
              final resp = validCharacters.hasMatch(value.toString());
              if (value == '' || value == null) {
                return 'Ingrese datos en campo';
              } else if (value.length < 6) {
                return 'Ingrese más de 6 caracteres';
              } else if (!resp) {
                return 'La contraseña no debe llevar espacios en blanco';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}
