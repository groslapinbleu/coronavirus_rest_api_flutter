import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class DateFormater {
  DateFormater({@required this.date});
  final DateTime date;

  String formatDateToString() {
    if (date != null) {
      final formatter = DateFormat.yMMMd().add_Hms();
      return formatter.format(date);
    }
    return '';
  }
}
