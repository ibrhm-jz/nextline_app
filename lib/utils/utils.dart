import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formattDateNumber(date) {
  String dateTime = DateFormat("dd/MMMM/y", 'es').format(date);
  return dateTime;
}

// pickDateDialog(BuildContext context) {
//   showDatePicker(
//     context: context,
//     initialDate: DateTime.now(),
//     firstDate: DateTime.utc(
//         DateTime.now().year - 1, DateTime.now().month, DateTime.now().day),
//     lastDate: DateTime.utc(
//         DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
//   ).then((pickedDate) {
//     if (pickedDate == null) {
//       return 'Selecciona fecha';
//     }
//     return pickedDate;
//   });
// }
