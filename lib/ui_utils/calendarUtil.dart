// import 'dart:collection';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:http/http.dart' as http;
// import 'package:unoquide/common/constants/constants.dart';

// /// Example event class.
// class Event {
//   String eventDescription;
//   String eventEnd;
//   String eventLabel;
//   String eventStart;
//   String eventTitle;
//   // List<String>? viewers;
//   Event({
//     required this.eventDescription,
//     required this.eventEnd,
//     required this.eventLabel,
//     required this.eventStart,
//     required this.eventTitle,
//     // this.viewers,
//   });

//   Event.fromJson(Map<String, dynamic> json)
//       : eventDescription = json['eventDescription'],
//         eventEnd = json['eventEnd'],
//         eventLabel = json['eventLabel'],
//         eventStart = json['eventStart'],
//         eventTitle = json['eventTitle'];
//   // // viewers = json['viewers'];
// }

// Future<List<Event>> fEvents() async {
//   List<Event> events = [];
//   final res = await http.get(Uri.parse("$baseURL/Event"));
//   if (res.statusCode == 200) {
//     var es = jsonDecode(res.body);
//     for (var e in es) {
//       events.add(Event.fromJson(e));
//     }
//   }
//   return events;
// }

// // / Example events.
// // /
// // / Using a [LinkedHashMap] is highly recommended if you decide to use a map.
// // final kEvents = LinkedHashMap<DateTime, List<Event>>(
// //   equals: isSameDay,
// //   hashCode: getHashCode,
// // )..addAll(_kEventSource);

// // final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
// //     key: (item) => DateTime.now().add(const Duration(days: 1)),
// //     value: (item) => fEvents().then((value) => )
// //     )
// //   ..addAll({
   
// //   });

// int getHashCode(DateTime key) {
//   return key.day * 1000000 + key.month * 10000 + key.year;
// }

// /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
// List<DateTime> daysInRange(DateTime first, DateTime last) {
//   final dayCount = last.difference(first).inDays + 1;
//   return List.generate(
//     dayCount,
//     (index) => DateTime.utc(first.year, first.month, first.day + index),
//   );
// }

// final kToday = DateTime.now();
// final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
// final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
