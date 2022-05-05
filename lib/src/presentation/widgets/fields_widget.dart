import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

class CustomFormField extends StatelessWidget {
  String labelField = '';
  String hintField = '';
  TextEditingController controller;
  bool isEnabled;
  double widthField;

  CustomFormField(
      {required this.labelField,
      required this.hintField,
      required this.controller,
      this.widthField = double.maxFinite,
      this.isEnabled = true,
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
            enabled: isEnabled,
            style: TextStyle(color: colorSecond, fontFamily: 'PoppinsSemiBold'),
            controller: controller,
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
  TextEditingController controller;

  CustomFormEmailField(
      {required this.controller,
      required this.labelField,
      this.widthField = double.maxFinite,
      Key? key})
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
            style: TextStyle(color: colorSecond, fontFamily: 'PoppinsSemiBold'),
            controller: controller,
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
  TextEditingController controller;

  CustomFormPasswordField(
      {required this.labelField,
      required this.controller,
      this.widthField = double.maxFinite,
      Key? key})
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
            controller: controller,
            style: TextStyle(color: colorSecond, fontFamily: 'PoppinsSemiBold'),
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

class CustomFormPiecesField extends StatelessWidget {
  String labelField = '';
  String hintField = '';
  TextEditingController controller;
  void Function(String)? functionOnChanged;
  double widthField;

  CustomFormPiecesField(
      {required this.labelField,
      required this.hintField,
      required this.controller,
      this.widthField = double.maxFinite,
      this.functionOnChanged,
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
            style: TextStyle(color: colorSecond, fontFamily: 'PoppinsSemiBold'),
            controller: controller,
            keyboardType: TextInputType.number,
            onChanged: functionOnChanged,
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
              if (value == '0' || value == 0) {
                return 'la cantidad debe ser mayor a 0';
              }

              return null;
            },
          ),
        ],
      ),
    );
  }
}

class CustomFormSelectField extends StatelessWidget {
  String labelField = '';
  String hintField = '';
  TextEditingController controller;

  double widthField;
  List<PopupMenuItem> items;
  void Function(dynamic)? onSelect;
  CustomFormSelectField(
      {required this.labelField,
      required this.hintField,
      required this.controller,
      required this.items,
      required this.onSelect,
      this.widthField = double.infinity,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color colorSecond = Theme.of(context).colorScheme.secondary;
    final widthScreen = MediaQuery.of(context).size.width;

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
          Container(
              height: 50.0,
              decoration: BoxDecoration(
                  color: Color(0xFFF8FDFF),
                  border: Border.all(color: colorSecond),
                  borderRadius: BorderRadius.circular(15.0)),
              child: Row(
                children: [
                  Container(
                    width: widthScreen * .60,
                    child: TextFormField(
                      enabled: false,
                      style: TextStyle(
                          color: colorSecond, fontFamily: 'PoppinsSemiBold'),
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: hintField,
                        hintStyle: const TextStyle(
                            color: Color(0xFF7FB3C5), fontFamily: 'Poppins'),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 12),
                        filled: false,
                        isDense: true,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == '' || value == null) {
                          return 'Este campo es requerido';
                        }

                        return null;
                      },
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  PopupMenuButton(
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: colorSecond,
                        size: 30.0,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      onSelected: onSelect,
                      itemBuilder: (BuildContext context) => items),
                ],
              ))

          /* DropdownButtonFormField(
            style: TextStyle(color: colorSecond, fontFamily: 'PoppinsSemiBold'),
            dropdownColor: Theme.of(context).colorScheme.background,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: colorSecond,
              size: 30.0,
            ),
            isExpanded: true,
            decoration: InputDecoration(

                floatingLabelAlignment: FloatingLabelAlignment.start,
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
            value: 1,
            onChanged: (value) {},
            items: [
              DropdownMenuItem(
                child: Text('HOla'),
                value: 1,
              )
            ],
          ), */
        ],
      ),
    );
  }
}

class FieldSelectForm extends StatelessWidget {
  FieldSelectForm(
      {required this.hintTextC,
      required this.labelTextInput,
      required this.controllerField,
      required this.items,
      this.functionOnChanged,
      this.widthField = double.maxFinite,
      this.typeDrop = SelectFormFieldType.dialog,
      Key? key})
      : super(key: key);

  final hintTextC;
  final labelTextInput;
  final controllerField;
  void Function(String)? functionOnChanged;
  final items;
  SelectFormFieldType typeDrop;
  double widthField;

  @override
  Widget build(BuildContext context) {
    Color colorSecond = Theme.of(context).colorScheme.secondary;
    return Container(
        width: widthField,
        margin: const EdgeInsets.only(top: 10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            labelTextInput,
            style: TextStyle(
                color: colorSecond, fontFamily: 'PoppinsLight', fontSize: 18.0),
          ),
          SelectFormField(
              onChanged: functionOnChanged,
              controller: controllerField,
              hintText: hintTextC,
              dialogCancelBtn: 'Cancelar',
              dialogTitle: labelTextInput,
              dialogSearchHint: 'Buscar',
              enableSearch: true,
              type: typeDrop,
              style:
                  TextStyle(color: colorSecond, fontFamily: 'PoppinsSemiBold'),
              decoration: InputDecoration(
                  fillColor: const Color(0xFFF8FDFF),
                  filled: true,
                  isDense: true,
                  hintStyle: const TextStyle(
                      color: Color(0xFF7FB3C5), fontFamily: 'Poppins'),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 12),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2.0, color: colorSecond)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: colorSecond)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: colorSecond))),
              items: items)
        ]));
  }
}
