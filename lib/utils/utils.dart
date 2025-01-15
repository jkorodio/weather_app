import 'package:intl/intl.dart';

String formatDate(String date) {
  try {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('MMMM dd - E').format(parsedDate);
  } catch (e) {
    return date;
  }
}
