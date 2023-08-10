import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:unoquide/astudents/models/studentModel.dart';
import 'package:unoquide/ateachers/models/teacher_model.dart';

Future<void> putTokenToGlobal({String? token}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token!);
}

Future<String> getTokenFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token;
  if (prefs.containsKey('token')) {
    token = prefs.getString('token')!;
  }
  token ??= '';
  return token;
}

Future<void> removeTokenFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

/// **********************************************///

Future<void> putUserTypeToGLobal({String? user}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('shareduser', user.toString());
}

Future<String> getUserTypeFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? user;
  if (prefs.containsKey('shareduser')) {
    user = prefs.getString('shareduser')!;
  }
  user ??= '';
  return user;
}

Future<void> removeUserTypeFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('shareduser');
}

/// **********************************************///
Future<void> putTeacherToGlobal({TeacherDataModel? teacher}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('teacher', jsonEncode(teacher));
}

Future<TeacherDataModel> getTeacherFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  TeacherDataModel? teacher;
  if (prefs.containsKey('teacher')) {
    teacher =
        TeacherDataModel.fromJson(jsonDecode(prefs.getString('teacher')!));
  }
  return teacher!;
}

Future<void> removeTeacherFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('teacher');
}

/// **********************************************///

Future<void> putParentTokenToGlobal(String? token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token!);
}

Future<String> getParentTokenFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token;
  if (prefs.containsKey('token')) {
    token = prefs.getString('token')!;
  }
  token ??= '';
  return token;
}

Future<void> removeParentTokenFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

Future<void> putStudentToGlobal({StudentModel? student}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('student', jsonEncode(student));
}

Future<StudentModel> getStudentFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  StudentModel? student;
  if (prefs.containsKey('student')) {
    student = StudentModel.fromJson(jsonDecode(prefs.getString('student')!));
  }
  return student!;
}

Future<void> removeStudentFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('student');
}
