// To parse this JSON data, do
//
//     final password = passwordFromJson(jsonString);

import 'dart:convert';

Password passwordFromJson(String str) => Password.fromJson(json.decode(str));

String passwordToJson(Password data) => json.encode(data.toJson());

class Password {
  Password({
    required this.student,
    required this.message,
  });

  Student student;
  String message;

  factory Password.fromJson(Map<String, dynamic> json) => Password(
        student: Student.fromJson(json["student"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "student": student.toJson(),
        "message": message,
      };
}

class Student {
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
  });

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
  String schoolName;

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
        schoolName: json["schoolName"],
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
        "schoolName": schoolName,
      };
}

class Image {
  Image({
    required this.eTag,
    required this.location,
    required this.key,
    required this.bucket,
  });

  String eTag;
  String location;
  String key;
  String bucket;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        eTag: json["ETag"],
        location: json["Location"],
        key: json["Key"],
        bucket: json["Bucket"],
      );

  Map<String, dynamic> toJson() => {
        "ETag": eTag,
        "Location": location,
        "Key": key,
        "Bucket": bucket,
      };
}
