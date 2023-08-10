import 'package:flutter/material.dart';

class MyCustomClass {
  const MyCustomClass();

  Future<void> myAsyncMethod(
      BuildContext context, VoidCallback onSuccess) async {
    await Future.delayed(const Duration(seconds: 2));
    onSuccess.call();
  }
}

class SplashScreenModel {
  initiateApp(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    Navigator.pushNamedAndRemoveUntil(context, '/categoryLogin', (route) => false);
  }
}
