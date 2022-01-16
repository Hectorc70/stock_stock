import 'package:flutter/material.dart';

Future<DateTime?> showCustomCalendar({
  required BuildContext context,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2021, 1, 30),
    lastDate: DateTime.now(),
  );
  return picked;
}
