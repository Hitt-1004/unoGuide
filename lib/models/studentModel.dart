// To parse this JSON data, do
//
//     final student = studentFromJson(jsonString);

import 'dart:convert';

Student studentFromJson(String? str) => Student.fromJson(json.decode(str!));

String? studentToJson(Student data) => json.encode(data.toJson());

class Student {
  String? id;
  String? firstName;
  String? lastName;
  String? admNo;
  Class? studentClass;
  DateTime dob;
  List<Subject>? subjects;
  List<Parent>? parents;
  String? bloodGroup;
  Img? image;
  List<dynamic>? documents;
  int? tuitionFee;
  int? transportFee;
  int? labFee;
  int? v;
  String? email;
  List<Notify> notifications;
  String? schoolName;
  Img? schoolLogo;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.admNo,
    required this.studentClass,
    required this.dob,
    required this.subjects,
    required this.parents,
    required this.bloodGroup,
    required this.image,
    required this.documents,
    required this.tuitionFee,
    required this.transportFee,
    required this.labFee,
    required this.v,
    required this.email,
    required this.notifications,
    required this.schoolName,
    required this.schoolLogo,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        admNo: json["admNo"],
        studentClass: Class.fromJson(json["class"]),
        dob: DateTime.parse(json["dob"]),
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
        parents:
            List<Parent>.from(json["parents"].map((x) => Parent.fromJson(x))),
        bloodGroup: json["bloodGroup"],
        image: Img.fromJson(json["image"]),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        tuitionFee: json["TuitionFee"],
        transportFee: json["TransportFee"],
        labFee: json["LabFee"],
        v: json["__v"],
        email: json["email"],
        notifications: List<Notify>.from(
            json["notifications"].map((x) => Notify.fromJson(x))),
        schoolName: json["schoolName"],
        schoolLogo: Img.fromJson(json["schoolLogo"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "admNo": admNo,
        "class": studentClass?.toJson(),
        "dob": dob.toIso8601String(),
        "subjects": List<dynamic>.from(subjects!.map((x) => x.toJson())),
        "parents": List<dynamic>.from(parents!.map((x) => x.toJson())),
        "bloodGroup": bloodGroup,
        "image": image!.toJson(),
        "documents": List<dynamic>.from(documents!.map((x) => x)),
        "TuitionFee": tuitionFee,
        "TransportFee": transportFee,
        "LabFee": labFee,
        "__v": v,
        "email": email,
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "schoolName": schoolName,
        "schoolLogo": schoolLogo!.toJson(),
      };
}

class Img {
  String? eTag;
  String? location;
  String? key;
  Bucket bucket;
  String? imageKey;

  Img({
    required this.eTag,
    required this.location,
    required this.key,
    required this.bucket,
    this.imageKey,
  });

  factory Img.fromJson(Map<String, dynamic> json) => Img(
        eTag: json["ETag"],
        location: json["Location"],
        key: json["Key"],
        bucket: bucketValues.map![json["Bucket"]]!,
        imageKey: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "ETag": eTag,
        "Location": location,
        "Key": key,
        "Bucket": bucketValues.reverse[bucket],
        "key": imageKey,
      };
}

enum Bucket { UNO_GUIDE_BUCKET_0 }

final bucketValues =
    EnumValues({"uno-guide-bucket-0": Bucket.UNO_GUIDE_BUCKET_0});

class Notify {
  String? id;
  String? sender;
  List<String> receiverId;
  String? senderId;
  String? title;
  String? text;
  bool? active;
  List<String> type;
  DateTime createdAt;
  DateTime updatedAt;
  int? v;
  String? meetingId;
  String? meetingName;

  Notify({
    required this.id,
    required this.sender,
    required this.receiverId,
    required this.senderId,
    required this.title,
    this.text,
    required this.active,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.meetingId,
    this.meetingName,
  });

  factory Notify.fromJson(Map<String, dynamic> json) => Notify(
        id: json["_id"],
        sender: json["sender"],
        receiverId: List<String>.from(json["receiver_id"].map((x) => x)),
        senderId: json["sender_id"],
        title: json["title"],
        text: json["text"],
        active: json["active"],
        type: List<String>.from(json["type"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        meetingId: json["meetingId"],
        meetingName: json["meetingName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender,
        "receiver_id": List<dynamic>.from(receiverId.map((x) => x)),
        "sender_id": senderId,
        "title": title,
        "text": text,
        "active": active,
        "type": List<dynamic>.from(type.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "meetingId": meetingId,
        "meetingName": meetingName,
      };
}

class Parent {
  String? id;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  List<String> children;
  int? v;

  Parent({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.email,
    required this.children,
    required this.v,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        image: json["image"],
        email: json["email"],
        children: List<String>.from(json["children"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "image": image,
        "email": email,
        "children": List<dynamic>.from(children.map((x) => x)),
        "__v": v,
      };
}

class Class {
  List<dynamic>? teachers;
  String? id;
  int? grade;
  String? div;
  String? school;
  int? v;
  String? classTeacher;

  Class({
    required this.teachers,
    required this.id,
    required this.grade,
    required this.div,
    required this.school,
    required this.v,
    required this.classTeacher,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        teachers: List<dynamic>.from(json["teachers"].map((x) => x)),
        id: json["_id"],
        grade: json["grade"],
        div: json["div"],
        school: json["school"],
        v: json["__v"],
        classTeacher: json["classTeacher"],
      );

  Map<String, dynamic> toJson() => {
        "teachers": List<dynamic>.from(teachers!.map((x) => x)),
        "_id": id,
        "grade": grade,
        "div": div,
        "school": school,
        "__v": v,
        "classTeacher": classTeacher,
      };
}

class Subject {
  List<dynamic> qaStatus;
  String? id;
  String? student;
  SubjectSubject subject;
  List<String> activityStatus;
  List<dynamic> recClassStatus;
  List<dynamic> animatedVideoStatus;
  List<dynamic> assignmentsStatus;
  int? v;
  List<String> notesStatus;
  List<String> gameStatus;

  Subject({
    required this.qaStatus,
    required this.id,
    required this.student,
    required this.subject,
    required this.activityStatus,
    required this.recClassStatus,
    required this.animatedVideoStatus,
    required this.assignmentsStatus,
    required this.v,
    required this.notesStatus,
    required this.gameStatus,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        qaStatus: List<dynamic>.from(json["qaStatus"].map((x) => x)),
        id: json["_id"],
        student: json["student"],
        subject: SubjectSubject.fromJson(json["subject"]),
        activityStatus: List<String>.from(json["activityStatus"].map((x) => x)),
        recClassStatus:
            List<dynamic>.from(json["recClassStatus"].map((x) => x)),
        animatedVideoStatus:
            List<dynamic>.from(json["animatedVideoStatus"].map((x) => x)),
        assignmentsStatus:
            List<dynamic>.from(json["assignmentsStatus"].map((x) => x)),
        v: json["__v"],
        notesStatus: List<String>.from(json["notesStatus"].map((x) => x)),
        gameStatus: List<String>.from(json["gameStatus"].map((x) => x)),
      );

  Map<String, dynamic>? toJson() => {
        "qaStatus": List<dynamic>.from(qaStatus.map((x) => x)),
        "_id": id,
        "student": student,
        "subject": subject.toJson(),
        "activityStatus": List<dynamic>.from(activityStatus.map((x) => x)),
        "recClassStatus": List<dynamic>.from(recClassStatus.map((x) => x)),
        "animatedVideoStatus":
            List<dynamic>.from(animatedVideoStatus.map((x) => x)),
        "assignmentsStatus":
            List<dynamic>.from(assignmentsStatus.map((x) => x)),
        "__v": v,
        "notesStatus": List<dynamic>.from(notesStatus.map((x) => x)),
        "gameStatus": List<dynamic>.from(gameStatus.map((x) => x)),
      };
}

class SubjectSubject {
  Status? status;
  String? id;
  String? name;
  int? grade;
  String? school;
  List<dynamic>? subSubjects;
  Img? image;
  List<Assignment>? notes;
  List<Assignment>? qa;
  List<Activity>? activity;
  List<Game>? game;
  List<Activity>? recClass;
  List<Activity>? animatedVideo;
  List<dynamic>? lessons;
  List<Assignment>? assignments;
  int? v;
  bool? public;

  SubjectSubject({
    required this.status,
    required this.id,
    required this.name,
    required this.grade,
    required this.school,
    required this.subSubjects,
    required this.image,
    required this.notes,
    required this.qa,
    required this.activity,
    required this.game,
    required this.recClass,
    required this.animatedVideo,
    required this.lessons,
    required this.assignments,
    required this.v,
    required this.public,
  });

  factory SubjectSubject.fromJson(Map<String, dynamic> json) => SubjectSubject(
        status: Status.fromJson(json["status"]),
        id: json["_id"],
        name: json["name"],
        grade: json["grade"],
        school: json["school"],
        subSubjects: List<dynamic>.from(json["subSubjects"].map((x) => x)),
        image: Img.fromJson(json["image"]),
        notes: List<Assignment>.from(
            json["notes"].map((x) => Assignment.fromJson(x))),
        qa: List<Assignment>.from(
            json["qa"].map((x) => Assignment.fromJson(x))),
        activity: List<Activity>.from(
            json["activity"].map((x) => Activity.fromJson(x))),
        game: List<Game>.from(json["game"].map((x) => Game.fromJson(x))),
        recClass: List<Activity>.from(
            json["recClass"].map((x) => Activity.fromJson(x))),
        animatedVideo: List<Activity>.from(
            json["animatedVideo"].map((x) => Activity.fromJson(x))),
        lessons: List<dynamic>.from(json["lessons"].map((x) => x)),
        assignments: List<Assignment>.from(
            json["assignments"].map((x) => Assignment.fromJson(x))),
        v: json["__v"],
        public: json["public"],
      );

  Map<String, dynamic> toJson() => {
        "status": status!.toJson(),
        "_id": id,
        "name": name,
        "grade": grade,
        "school": school,
        "subSubjects": List<dynamic>.from(subSubjects!.map((x) => x)),
        "image": image!.toJson(),
        "notes": List<dynamic>.from(notes!.map((x) => x.toJson())),
        "qa": List<dynamic>.from(qa!.map((x) => x.toJson())),
        "activity": List<dynamic>.from(activity!.map((x) => x.toJson())),
        "game": List<dynamic>.from(game!.map((x) => x.toJson())),
        "recClass": List<dynamic>.from(recClass!.map((x) => x.toJson())),
        "animatedVideo":
            List<dynamic>.from(animatedVideo!.map((x) => x.toJson())),
        "lessons": List<dynamic>.from(lessons!.map((x) => x)),
        "assignments": List<dynamic>.from(assignments!.map((x) => x.toJson())),
        "__v": v,
        "public": public,
      };
}

class Activity {
  String? name;
  String? video;
  String? image;

  Activity({
    required this.name,
    required this.video,
    required this.image,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        name: json["Name"],
        video: json["video"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "video": video,
        "image": image,
      };
}

class Assignment {
  String? name;
  Img? file;

  Assignment({
    required this.name,
    required this.file,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        name: json["name"],
        file: Img.fromJson(json["file"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "file": file!.toJson(),
      };
}

class Game {
  String? name;
  String? url;

  Game({
    required this.name,
    required this.url,
  });

  factory Game.fromJson(Map<String, dynamic> json) => Game(
        name: json["Name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "Name": name,
        "url": url,
      };
}

class Status {
  dynamic teacherId;
  bool? isSelected;

  Status({
    this.teacherId,
    required this.isSelected,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        teacherId: json["teacherId"],
        isSelected: json["isSelected"],
      );

  Map<String, dynamic> toJson() => {
        "teacherId": teacherId,
        "isSelected": isSelected,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  late Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map!.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
