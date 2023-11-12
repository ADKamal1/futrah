import 'package:intl/intl.dart';

class TimeFormat {
  TimeFormat._();

  static TimeFormat get instance => TimeFormat._();

  String formatDate(String format, DateTime dateTime) {
    return DateFormat(format).format(dateTime);
  }
}

const String yyyyMmDd = 'yyyy-MM-dd';
const String ddMmYyyy = 'dd-MM-yyyy';
const String ddMmYyyyWithSlash = 'dd / MM / yyyy';
const String mmYyyy = 'MM-yyyy';
const String mmDdYyyyHhMm = 'MM/dd/yyyy HH:mm';
const String ddMmYyyyHhMm = 'HH:mm dd/MM/yyyy';
const String notificationFormat = 'dd-MM-yyyy hh:mm aa';
