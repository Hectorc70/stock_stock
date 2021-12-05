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
            decoration: InputDecoration(
                hintText: hintField,
                hintStyle: TextStyle(
                    color: const Color(0xFF7FB3C5), fontFamily: 'Poppins'),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 12),
                filled: true,
                isDense: true,
                fillColor: const Color(0xFFF8FDFF),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(width: 20.0, color: colorSecond)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colorSecond)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: colorSecond))),
          )
        ],
      ),
    );
  }
}
