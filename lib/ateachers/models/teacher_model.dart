// To parse this JSON data, do
//
//     final teacherDataModel = teacherDataModelFromJson(jsonString);

import 'dart:convert';

TeacherDataModel teacherDataModelFromJson(String str) =>
    TeacherDataModel.fromJson(json.decode(str));

String teacherDataModelToJson(TeacherDataModel data) =>
    json.encode(data.toJson());

class TeacherDataModel {
  String id;
  String firstName;
  String lastName;
  String classTeacher;
  String email;
  DateTime dob;
  String bloodGroup;
  School school;
  List<Class> classes;
  List<Subject> subjects;
  Image image;
  List<Notification> notifications;
  List<Image> documents;
  int v;
  bool is2Fa;
  Image schoolLogo;

  TeacherDataModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.classTeacher,
    required this.email,
    required this.dob,
    required this.bloodGroup,
    required this.school,
    required this.classes,
    required this.subjects,
    required this.image,
    required this.notifications,
    required this.documents,
    required this.v,
    required this.is2Fa,
    required this.schoolLogo,
  });

  factory TeacherDataModel.fromJson(Map<String, dynamic> json) =>
      TeacherDataModel(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        classTeacher: json["classTeacher"],
        email: json["email"],
        dob: DateTime.parse(json["dob"]),
        bloodGroup: json["bloodGroup"],
        school: School.fromJson(json["school"]),
        classes:
            List<Class>.from(json["classes"].map((x) => Class.fromJson(x))),
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
        image: Image.fromJson(json["image"]),
        notifications: List<Notification>.from(
            json["notifications"].map((x) => Notification.fromJson(x))),
        documents:
            List<Image>.from(json["documents"].map((x) => Image.fromJson(x))),
        v: json["__v"],
        is2Fa: json["is2FA"],
        schoolLogo: Image.fromJson(json["schoolLogo"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "classTeacher": classTeacher,
        "email": email,
        "dob": dob.toIso8601String(),
        "bloodGroup": bloodGroup,
        "school": school.toJson(),
        "classes": List<dynamic>.from(classes.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
        "image": image.toJson(),
        "notifications":
            List<dynamic>.from(notifications.map((x) => x.toJson())),
        "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
        "__v": v,
        "is2FA": is2Fa,
        "schoolLogo": schoolLogo.toJson(),
      };
}

class Class {
  List<dynamic> teachers;
  String id;
  int grade;
  String div;
  Id school;
  List<Student> students;
  List<String> subjects;
  int v;
  String classTeacher;

  Class({
    required this.teachers,
    required this.id,
    required this.grade,
    required this.div,
    required this.school,
    required this.students,
    required this.subjects,
    required this.v,
    required this.classTeacher,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        teachers: List<dynamic>.from(json["teachers"].map((x) => x)),
        id: json["_id"],
        grade: json["grade"],
        div: json["div"],
        school: idValues.map[json["school"]]!,
        students: List<Student>.from(
            json["students"].map((x) => Student.fromJson(x))),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        v: json["__v"],
        classTeacher: json["classTeacher"],
      );

  Map<String, dynamic> toJson() => {
        "teachers": List<dynamic>.from(teachers.map((x) => x)),
        "_id": id,
        "grade": grade,
        "div": div,
        "school": idValues.reverse[school],
        "students": List<dynamic>.from(students.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "__v": v,
        "classTeacher": classTeacher,
      };
}

enum Id { THE_63275848690_AC78_EFD493_FCD, THE_6371_FE9_CB6367_ACD95387644 }

final idValues = EnumValues({
  "63275848690ac78efd493fcd": Id.THE_63275848690_AC78_EFD493_FCD,
  "6371fe9cb6367acd95387644": Id.THE_6371_FE9_CB6367_ACD95387644
});

class Student {
  String id;
  String firstName;
  String lastName;
  String admNo;
  String password;
  String studentClass;
  DateTime dob;
  List<String> subjects;
  List<String> parents;
  String bloodGroup;
  Image image;
  List<dynamic> documents;

  int tuitionFee;
  int transportFee;
  int labFee;
  int v;
  String email;
  List<String> notifications;
  SchoolName schoolName;
  bool is2Fa;

  Student({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.admNo,
    required this.password,
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
    required this.is2Fa,
  });

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        admNo: json["admNo"],
        password: json["password"],
        studentClass: json["class"],
        dob: DateTime.parse(json["dob"]),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        parents: List<String>.from(json["parents"].map((x) => x)),
        bloodGroup: json["bloodGroup"],
        image: Image.fromJson(json["image"]),
        documents: List<dynamic>.from(json["documents"].map((x) => x)),
        tuitionFee: json["TuitionFee"],
        transportFee: json["TransportFee"],
        labFee: json["LabFee"],
        v: json["__v"],
        email: json["email"],
        notifications: List<String>.from(json["notifications"].map((x) => x)),
        schoolName: schoolNameValues.map[json["schoolName"]]!,
        is2Fa: json["is2FA"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "firstName": firstName,
        "lastName": lastName,
        "admNo": admNo,
        "password": password,
        "class": studentClass,
        "dob": dob.toIso8601String(),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "parents": List<dynamic>.from(parents.map((x) => x)),
        "bloodGroup": bloodGroup,
        "image": image.toJson(),
        "documents": List<dynamic>.from(documents.map((x) => x)),
        "TuitionFee": tuitionFee,
        "TransportFee": transportFee,
        "LabFee": labFee,
        "__v": v,
        "email": email,
        "notifications": List<dynamic>.from(notifications.map((x) => x)),
        "schoolName": schoolNameValues.reverse[schoolName],
        "is2FA": is2Fa,
      };
}

class Image {
  String eTag;
  String? serverSideEncryption;
  String location;
  String key;
  Bucket bucket;
  String? imageKey;

  Image({
    required this.eTag,
    this.serverSideEncryption,
    required this.location,
    required this.key,
    required this.bucket,
    this.imageKey,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        eTag: json["ETag"],
        serverSideEncryption: json["ServerSideEncryption"],
        location: json["Location"],
        key: json["Key"],
        bucket: bucketValues.map[json["Bucket"]]!,
        imageKey: json["key"],
      );

  Map<String, dynamic> toJson() => {
        "ETag": eTag,
        "ServerSideEncryption": serverSideEncryption,
        "Location": location,
        "Key": key,
        "Bucket": bucketValues.reverse[bucket],
        "key": imageKey,
      };
}

enum Bucket { UNO_GUIDE_BUCKET_0 }

final bucketValues =
    EnumValues({"uno-guide-bucket-0": Bucket.UNO_GUIDE_BUCKET_0});

enum SchoolName { SWATI_SINGH, OASIS }

final schoolNameValues = EnumValues(
    {"Oasis": SchoolName.OASIS, "Swati Singh": SchoolName.SWATI_SINGH});

class Notification {
  String id;
  SchoolName? sender;
  List<String> receiverId;
  Id? senderId;
  String? title;
  String? text;
  bool active;
  String? meetingName;
  String? meetingId;

  DateTime createdAt;
  DateTime updatedAt;
  int v;
  Id? school;

  Notification({
    required this.id,
    this.sender,
    required this.receiverId,
    this.senderId,
    this.title,
    this.text,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.school,
    this.meetingName,
    this.meetingId,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"],
        sender: schoolNameValues.map[json["sender"]],
        receiverId: List<String>.from(json["receiver_id"].map((x) => x)),
        senderId: idValues.map[json["sender_id"]],
        title: json["title"],
        text: json["text"],
        active: json["active"],
        //  type: List<Type>.from(json["type"].map((x) => typeValues.map[x]!)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        school: idValues.map[json["school"]],
        meetingName: json["meetingName"],
        meetingId: json["meetingId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": schoolNameValues.reverse[sender],
        "receiver_id": List<dynamic>.from(receiverId.map((x) => x)),
        "sender_id": idValues.reverse[senderId],
        "title": title,
        "text": text,
        "active": active,
        //   "type": List<dynamic>.from(type!.map((x) => typeValues.reverse[x])),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "school": idValues.reverse[school],
        "meetingName": meetingName,
        "meetingId": meetingId,
      };
}

enum Type { CUSTOM }

final typeValues = EnumValues({"custom": Type.CUSTOM});

class School {
  Id id;
  SchoolName schoolName;

  School({
    required this.id,
    required this.schoolName,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: idValues.map[json["_id"]]!,
        schoolName: schoolNameValues.map[json["schoolName"]]!,
      );

  Map<String, dynamic> toJson() => {
        "_id": idValues.reverse[id],
        "schoolName": schoolNameValues.reverse[schoolName],
      };
}

class Subject {
  Status status;
  String id;
  String name;
  int grade;

  Id school;
  List<dynamic> subSubjects;
  bool public;
  Image image;
  List<dynamic> notes;
  List<dynamic> qa;
  List<Activity> activity;
  List<dynamic> game;
  List<Activity> recClass;
  List<Activity> animatedVideo;
  List<dynamic> lessons;
  List<dynamic> assignments;
  int v;

  Subject({
    required this.status,
    required this.id,
    required this.name,
    required this.grade,
    required this.school,
    required this.subSubjects,
    required this.public,
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
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        status: Status.fromJson(json["status"]),
        id: json["_id"],
        name: json["name"],
        grade: json["grade"],
        school: idValues.map[json["school"]]!,
        subSubjects: List<dynamic>.from(json["subSubjects"].map((x) => x)),
        public: json["public"],
        image: Image.fromJson(json["image"]),
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
        qa: List<dynamic>.from(json["qa"].map((x) => x)),
        activity: List<Activity>.from(
            json["activity"].map((x) => Activity.fromJson(x))),
        game: List<dynamic>.from(json["game"].map((x) => x)),
        recClass: List<Activity>.from(
            json["recClass"].map((x) => Activity.fromJson(x))),
        animatedVideo: List<Activity>.from(
            json["animatedVideo"].map((x) => Activity.fromJson(x))),
        lessons: List<dynamic>.from(json["lessons"].map((x) => x)),
        assignments: List<dynamic>.from(json["assignments"].map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "status": status.toJson(),
        "_id": id,
        "name": name,
        "grade": grade,
        "school": idValues.reverse[school],
        "subSubjects": List<dynamic>.from(subSubjects.map((x) => x)),
        "public": public,
        "image": image.toJson(),
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "qa": List<dynamic>.from(qa.map((x) => x)),
        "activity": List<dynamic>.from(activity.map((x) => x.toJson())),
        "game": List<dynamic>.from(game.map((x) => x)),
        "recClass": List<dynamic>.from(recClass.map((x) => x.toJson())),
        "animatedVideo":
            List<dynamic>.from(animatedVideo.map((x) => x.toJson())),
        "lessons": List<dynamic>.from(lessons.map((x) => x)),
        "assignments": List<dynamic>.from(assignments.map((x) => x)),
        "__v": v,
      };
}

class Activity {
  String name;
  String video;
  String image;

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

class Status {
  dynamic teacherId;
  bool isSelected;

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
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
