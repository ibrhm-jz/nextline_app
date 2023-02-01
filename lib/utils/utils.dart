import 'package:intl/intl.dart';

String formattDateNumber(date) {
  String dateTime = DateFormat("dd/MMMM/y", 'es').format(date);
  return dateTime;
}
