import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class LastUpdatedDateFormater {
  LastUpdatedDateFormater({@required this.date});
  final DateTime date;

  String formatDateToString() {
    if (date != null) {
      final formatter = DateFormat.yMMMd().add_Hms();
      final formatted = formatter.format(date);
      return 'Last updated : $formatted';
    }
    return '';
  }
}
