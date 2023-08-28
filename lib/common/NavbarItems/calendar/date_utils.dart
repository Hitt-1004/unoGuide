import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);

    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd().format(dateTime);

    return '$date';
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm().format(dateTime);

    return "$time";
  }

  static List<dynamic> format(String dateTime) {
    var dateFormat =
        DateFormat("dd-MM-yyyy hh:mm aa"); // you can change the format here
    var utcDate =
        dateFormat.format(DateTime.parse(dateTime)); // pass the UTC time here
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();
    String createdDate = dateFormat.format(DateTime.parse(localDate));
    // 0-> complete date, 20-7-2023 12:00 AM
    // 1-> time only, 12:00
    // 2-> day, AM or PM
    // 2-> date only, 20-7-2023
    String timeOnly = createdDate.split(" ")[1];
    String day = createdDate.split(" ")[2];
    String date = createdDate = createdDate.split(" ")[0];
    return [createdDate, timeOnly, day, date];
  }

  static bool checkSameDay(DateTime? dateA, DateTime? dateB) {
    return format(dateA.toString())[3] == format(dateB.toString())[3];
    // dateA?.year == dateB?.year &&
    // dateA?.month == dateB?.month &&
    // dateA?.day == dateB?.day;
  }
}
