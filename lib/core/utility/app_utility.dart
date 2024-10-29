import 'package:intl/intl.dart';

class AppUtility {
  AppUtility._();

  static String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('yyyy-MM-dd hh:mm a');
    return formatter.format(dateTime);
  }
}