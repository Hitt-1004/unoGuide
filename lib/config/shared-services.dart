import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:unoguide/models/parentModel.dart';
import '../models/studentModel.dart';

Future<bool> checkLoginStatus() async {
  getTokenFromGlobal().then((value) {
    if(value != '') return true;
  });
  return false;
}

Future<void> putIndexToGlobal({int? index}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('index', index!);
}

Future<int> getIndexFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? index;
  if (prefs.containsKey('index')) {
    index = prefs.getInt('index')!;
  }
  index ??= 0;
  return index;
}

Future<void> putAdmNoToGlobal({String? admNo}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('admNo', admNo!);
}

Future<String> getAdmNoFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? admNo;
  if (prefs.containsKey('admNo')) {
    admNo = prefs.getString('admNo')!;
  }
  admNo ??= '';
  return admNo;
}

Future<void> putSchoolLogoToGlobal({String? schoolLogo}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('schoolLogo', schoolLogo!);
}

Future<String> getSchoolLogoFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? schoolLogo;
  if (prefs.containsKey('schoolLogo')) {
    schoolLogo = prefs.getString('schoolLogo')!;
  }
  schoolLogo ??= '';
  return schoolLogo;
}

Future<void> putSchoolIdToGlobal({String? schoolId}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('schoolId', schoolId!);
}

Future<String> getSchoolIdFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? schoolId;
  if (prefs.containsKey('schoolId')) {
    schoolId = prefs.getString('schoolId')!;
  }
  schoolId ??= '';
  return schoolId;
}

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
  await prefs.remove('student');
  await prefs.remove('email');
}

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

Future<void> putStudentToGlobal({Student? student}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('student', jsonEncode(student));
}

Future<Student> getStudentFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Student? student;
  if (prefs.containsKey('student')) {
    student = Student.fromJson(jsonDecode(prefs.getString('student')!));
  }
  return student!;
}

Future<void> putParentToGlobal({ParentModel? parent}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.setString('parent', jsonEncode(parent));
}

Future<ParentModel> getParentFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  ParentModel? parent;
  if (prefs.containsKey('parent')) {
    parent = parentFromJson(prefs.getString('parent')!);
  }
  return parent!;
}

// put email to local storage
Future<void> putEmailToGlobal({String? email}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  print("Received email: $email");
  await prefs.setString('email', email!);
}

Future<String> getEmailFromGlobal() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? email;
  if (prefs.containsKey('email')) {
    email = prefs.getString('email')!;
  }
  email ??= '';
  return email;
}
