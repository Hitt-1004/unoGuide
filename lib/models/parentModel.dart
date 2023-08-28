import 'dart:convert';

ParentModel parentFromJson(String str) => ParentModel.fromJson(json.decode(str));

String parentToJson(ParentModel data) => json.encode(data.toJson());

class ParentModel {
  ParentModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.email,
    required this.password,
    required this.schoolName,
    required this.children,
    required this.notifications,
    required this.v,
    required this.schoolLogo
  });

  String id;
  String firstName;
  String lastName;
  String image;
  String email;
  String password;
  List<Child> children;
  List<dynamic> notifications;
  int v;
  String schoolName;
  Logo schoolLogo;

  factory ParentModel.fromJson(Map<String, dynamic> json) => ParentModel(
    id: json["_id"] ?? '',
    firstName: json["firstName"] ?? '',
    lastName: json["lastName"]  ?? '',
    image: json["image"]  ?? '',
    email: json["email"]  ?? '',
    password: json["password"]  ?? '',
    children:
    List<Child>.from(json["children"].map((x) => Child.fromJson(x))),
    notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
    v: json["__v"]  ?? 0,
    schoolName: json["schoolName"]  ?? '',
    schoolLogo: Logo.fromJson(json['schoolLogo']),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "image": image,
    "email": email,
    "password": password,
    "children": List<dynamic>.from(children.map((x) => x.toJson())),
    "notifications": List<dynamic>.from(notifications.map((x) => x)),
    "__v": v,
    "schoolName": schoolName,
    "schoolLogo": schoolLogo.toJson()
  };
}

class Logo {
  Logo({
    required this.Location,
    required this.ETag,
    required this.key,
    required this.Key,
    required this.Bucket
  });

  String ETag;
  String Location;
  String key;
  String Key;
  String Bucket;

  factory Logo.fromJson(Map<String, dynamic> json) => Logo(
    ETag: json['ETag'],
    Location: json['Location'],
    key: json['key'],
    Key: json['Key'],
    Bucket: json['Bucket']
  );

  Map<String, dynamic> toJson() => {
    "ETag": ETag,
    "Location": Location,
    "key": key,
    "Key": Key,
    "Bucket": Bucket
  };
}

class Child {
  Child({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.admNo,
    required this.childClass,
    required this.dob,
    required this.subjects,
    required this.parents,
    required this.bloodGroup,
    required this.image,
    required this.documents,
    required this.stream,
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
  Class childClass;
  DateTime dob;
  List<Subject> subjects;
  List<dynamic> parents;
  String bloodGroup;
  Image image;
  List<dynamic> documents;
  String stream;
  int tuitionFee;
  int transportFee;
  int labFee;
  int v;
  String email;
  List<dynamic> notifications;
  String schoolName;

  factory Child.fromJson(Map<String, dynamic> json) => Child(
    id: json["_id"]  ?? '',
    firstName: json["firstName"]  ?? '',
    lastName: json["lastName"]  ?? '',
    admNo: json["admNo"]  ?? '',
    childClass: Class.fromJson(json["class"]),
    dob: DateTime.parse(json["dob"]),
    subjects: List<Subject>.from(
        json["subjects"].map((x) => Subject.fromJson(x))),
    parents: List<dynamic>.from(json["parents"].map((x) => x)),
    bloodGroup: json["bloodGroup"]  ?? '',
    image: Image.fromJson(json["image"]),
    documents: List<dynamic>.from(json["documents"].map((x) => x)),
    stream: json["stream"]  ?? '',
    tuitionFee: json["TuitionFee"]  ?? 0,
    transportFee: json["TransportFee"]  ?? 0,
    labFee: json["LabFee"]  ?? 0,
    v: json["__v"]  ?? 0,
    email: json["email"]  ?? '',
    notifications: List<dynamic>.from(json["notifications"].map((x) => x)),
    schoolName: json["schoolName"]  ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "admNo": admNo,
    "class": childClass.toJson(),
    "dob": dob.toIso8601String(),
    "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
    "parents": List<dynamic>.from(parents.map((x) => x)),
    "bloodGroup": bloodGroup,
    "image": image.toJson(),
    "documents": List<dynamic>.from(documents.map((x) => x)),
    "stream": stream,
    "TuitionFee": tuitionFee,
    "TransportFee": transportFee,
    "LabFee": labFee,
    "__v": v,
    "email": email,
    "notifications": List<dynamic>.from(notifications.map((x) => x)),
    "schoolName": schoolName,
  };
}

class Class {
  Class({
    required this.id,
    required this.grade,
    required this.div,
    required this.school,
    required this.subjects,
    required this.v,
    required this.classTeacher,
  });

  String id;
  int grade;
  String div;
  String school;
  List<dynamic> subjects;
  int v;
  String classTeacher;

  factory Class.fromJson(Map<String, dynamic> json) => Class(
    id: json["_id"]  ?? '',
    grade: json["grade"]  ?? 0,
    div: json["div"]  ?? '',
    school: json["school"]  ?? '',
    subjects: List<dynamic>.from(json["subjects"].map((x) => x)),
    v: json["__v"]  ?? 0,
    classTeacher: json["classTeacher"]  ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "grade": grade,
    "div": div,
    "school": school,
    "subjects": List<dynamic>.from(subjects.map((x) => x)),
    "__v": v,
    "classTeacher": classTeacher,
  };
}

class Image {
  Image({
    required this.eTag,
    this.serverSideEncryption,
    required this.location,
    required this.key,
    required this.bucket,
    this.imageKey,
  });

  String eTag;
  String? serverSideEncryption;
  String location;
  String key;
  Bucket bucket;
  String? imageKey;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    eTag: json["ETag"]  ?? '',
    serverSideEncryption: json["ServerSideEncryption"]  ?? '',
    location: json["Location"]  ?? '',
    key: json["Key"]  ?? '',
    bucket: bucketValues.map[json["Bucket"]]!,
    imageKey: json["key"]  ?? '',
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

class Subject {
  Subject({
    required this.notesStatus,
    required this.gameStatus,
    required this.qaStatus,
    required this.id,
    required this.student,
    required this.subject,
    required this.activityStatus,
    required this.recClassStatus,
    required this.animatedVideoStatus,
    required this.assignmentsStatus,
    required this.v,
  });

  List<dynamic> notesStatus;
  List<dynamic> gameStatus;
  List<dynamic> qaStatus;
  String id;
  String student;
  Subsubject subject;
  List<dynamic> activityStatus;
  List<dynamic> recClassStatus;
  List<dynamic> animatedVideoStatus;
  List<dynamic> assignmentsStatus;
  int v;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    notesStatus: List<dynamic>.from(json["notesStatus"].map((x) => x)),
    gameStatus: List<dynamic>.from(json["gameStatus"].map((x) => x)),
    qaStatus: List<dynamic>.from(json["qaStatus"].map((x) => x)),
    id: json["_id"]  ?? '',
    student: json["student"]  ?? '',
    subject: Subsubject.fromJson(json["subject"]),
    activityStatus:
    List<dynamic>.from(json["activityStatus"].map((x) => x)),
    recClassStatus: List<dynamic>.from(json["recClassStatus"].map((x) => x)),
    animatedVideoStatus:
    List<dynamic>.from(json["animatedVideoStatus"].map((x) => x)),
    assignmentsStatus:
    List<dynamic>.from(json["assignmentsStatus"].map((x) => x)),
    v: json["__v"]  ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "notesStatus": List<dynamic>.from(notesStatus.map((x) => x)),
    "gameStatus": List<dynamic>.from(gameStatus.map((x) => x)),
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
  };
}

class Subsubject {
  Subsubject({
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
    this.div,
    this.stream,
  });

  Status status;
  String id;
  String name;
  int grade;
  String school;
  List<Subsubject> subSubjects;
  Image image;
  List<Note> notes;
  List<dynamic> qa;
  List<Activity> activity;
  List<Game> game;
  List<Activity> recClass;
  List<Activity> animatedVideo;
  List<dynamic> lessons;
  List<dynamic> assignments;
  int v;
  bool public;
  String? div;
  String? stream;

  factory Subsubject.fromJson(Map<String, dynamic> json) => Subsubject(
    status: Status.fromJson(json["status"]),
    id: json["_id"]  ?? '',
    name: json["name"]  ?? '',
    grade: json["grade"]  ?? 0,
    school: json["school"]  ?? '',
    subSubjects: List<Subsubject>.from(
        json["subSubjects"].map((x) => Subsubject.fromJson(x))),
    image: Image.fromJson(json["image"]),
    notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
    qa: List<dynamic>.from(json["qa"].map((x) => x)),
    activity: List<Activity>.from(
        json["activity"].map((x) => Activity.fromJson(x))),
    game: List<Game>.from(json["game"].map((x) => Game.fromJson(x))),
    recClass: List<Activity>.from(
        json["recClass"].map((x) => Activity.fromJson(x))),
    animatedVideo: List<Activity>.from(
        json["animatedVideo"].map((x) => Activity.fromJson(x))),
    lessons: List<dynamic>.from(json["lessons"].map((x) => x)),
    assignments: List<dynamic>.from(json["assignments"].map((x) => x)),
    v: json["__v"]  ?? 0,
    public: json["public"]  ?? false,
    div: json["div"]  ?? '',
    stream: json["stream"]  ?? '',
  );

  Map<String, dynamic> toJson() => {
    "status": status.toJson(),
    "_id": id,
    "name": name,
    "grade": grade,
    "school": school,
    "subSubjects": List<dynamic>.from(subSubjects.map((x) => x.toJson())),
    "image": image.toJson(),
    "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
    "qa": List<dynamic>.from(qa.map((x) => x)),
    "activity": List<dynamic>.from(activity.map((x) => x.toJson())),
    "game": List<dynamic>.from(game.map((x) => x.toJson())),
    "recClass": List<dynamic>.from(recClass.map((x) => x.toJson())),
    "animatedVideo":
    List<dynamic>.from(animatedVideo.map((x) => x.toJson())),
    "lessons": List<dynamic>.from(lessons.map((x) => x)),
    "assignments": List<dynamic>.from(assignments.map((x) => x)),
    "__v": v,
    "public": public,
    "div": div,
    "stream": stream,
  };
}

class Activity {
  Activity({
    required this.name,
    required this.video,
    required this.image,
  });

  String name;
  String video;
  String image;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    name: json["Name"]  ?? '',
    video: json["video"]  ?? '',
    image: json["image"]  ?? '',
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "video": video,
    "image": image,
  };
}

class Game {
  Game({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory Game.fromJson(Map<String, dynamic> json) => Game(
    name: json["Name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "Name": name,
    "url": url,
  };
}

class Note {
  Note({
    required this.name,
    required this.file,
  });

  String name;
  Image file;

  factory Note.fromJson(Map<String, dynamic> json) => Note(
    name: json["name"]  ?? '',
    file: Image.fromJson(json["file"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "file": file.toJson(),
  };
}

class Status {
  Status({
    this.teacherId,
    required this.isSelected,
  });

  dynamic teacherId;
  bool isSelected;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    teacherId: json["teacherId"]  ?? '',
    isSelected: json["isSelected"]  ?? false,
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
