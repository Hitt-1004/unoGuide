import 'package:dyte_client/dyteSelfParticipant.dart';
import 'package:flutter/material.dart';

class TeacherClassProvider extends ChangeNotifier {
  // endpoint to get all info of a class => https://backend.unoguide.in/teacher/notificationInfo/63275848690ac78efd493fcd
  List<String> classes = [];
  String classId = '';
  String schoolId = '';
  String teacherId = '';
  String grade = '';
  String section = '';
  String roomId = '';
  String roomName = '';
  bool isMeetingJoined = false;
  String meetingToken = '';
  String currentUserType = '';
  late DyteSelfParticipant self;
  String isMiddle = "";

  // set current user type
  void setCurrentUserType(String type) {
    currentUserType = type;
    print(currentUserType + " this is the current user type ");
    notifyListeners();
  }

  // functions to set dyte self participant
  void setDyteSelfParticipant(self) {
    this.self = self;
    notifyListeners();
  }

  void setDyteMeeingAuthToken(String token) {
    meetingToken = token;
    notifyListeners();
  }

  void setRoomIdandRoomName(String id, String roomName) {
    roomId = id;
    this.roomName = roomName;
    notifyListeners();
  }

  void setMeetingJoined(bool val) {
    isMeetingJoined = val;
    notifyListeners();
  }

  // functions to set teacher related data
  void setTeacherId(String id) {
    teacherId = id;
    notifyListeners();
  }

  void setClassId(String id) {
    classId = id;
    notifyListeners();
  }

  void setSchoolId(String id) {
    schoolId = id;
    notifyListeners();
  }

  void setClasses(String grade, String section) {
    String currClass = "$grade-$section";
    if (double.parse(grade) < 5) {
      isMiddle = "Lower";
    } else if (double.parse(grade) > 5 && double.parse(grade) < 9) {
      isMiddle = "Middle";
    } else {
      isMiddle = "Higher";
    }
    bool flag = false;
    for (String cl in classes) {
      if (cl == currClass && classes.isNotEmpty) {
        flag = true;
        break;
      }
    }
    if (flag == false) {
      this.grade = grade;
      this.section = section;
      classes.add("$grade-$section");
    }
    notifyListeners();
  }

  // clear all data
  void clearAllProviderData() {
    classes = [];
    classId = '';
    schoolId = '';
    teacherId = '';
    grade = '';
    section = '';
    isMeetingJoined = false;
    roomId = '';
    roomName = '';
    meetingToken = '';
    currentUserType = '';
    notifyListeners();
  }
}
