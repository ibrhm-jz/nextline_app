import 'package:intl/intl.dart';

String formattDateNumber(date) {
  String dateTime = DateFormat("dd/MMMM/y", 'es').format(date);
  return dateTime;
}

formattDateSendApi(date) {
  if (date != null) {
    String dateTime = DateFormat("yyyy-MM-dd").format(date);
    return dateTime;
  } else {
    return date;
  }
}
