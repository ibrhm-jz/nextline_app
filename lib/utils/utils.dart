import 'package:intl/intl.dart';

String formattDateNumber(date) {
  String dateTime = DateFormat("dd/MMMM/y", 'es').format(date);
  return dateTime;
}

String formattDateSendApi(date) {
  String dateTime = DateFormat("yyyy-MM-dd").format(date);
  return dateTime;
}
