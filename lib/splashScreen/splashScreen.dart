import 'package:flutter/material.dart';
import 'package:unoguide/constants.dart';

import 'splashScreenModel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenModel splashViewModel = SplashScreenModel();

  @override
  void initState() {
    super.initState();
    splashViewModel.initiateApp(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: Image.asset('assets/Icons/logo.png'),
      ),
    );
  }
}
