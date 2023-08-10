// To parse this JSON data, do
//
//     final events = eventsFromJson(jsonString);

import 'dart:convert';

Events eventsFromJson(String str) => Events.fromJson(json.decode(str));

String eventsToJson(Events data) => json.encode(data.toJson());

class Events {
  DateTime eventStart;
  DateTime eventEnd;
  String eventTitle;
  String eventDescription;
  String schoolId;

  List<String>? viewers;

  Events({
    required this.eventStart,
    required this.eventEnd,
    required this.eventTitle,
    required this.eventDescription,
    required this.schoolId,
    this.viewers,
  });

  factory Events.fromJson(Map<String, dynamic> json) => Events(
        eventStart: DateTime.parse(json["eventStart"]),
        eventEnd: DateTime.parse(json["eventEnd"]),
        eventTitle: json["eventTitle"],
        eventDescription: json["eventDescription"],
        schoolId: json["schoolId"],
        viewers: List<String>.from(json["viewers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "eventStart": eventStart.toIso8601String(),
        "eventEnd": eventEnd.toIso8601String(),
        "eventTitle": eventTitle,
        "eventDescription": eventDescription,
        "schoolId": schoolId,
        "viewers": List<dynamic>.from(viewers!.map((x) => x)),
      };
}
