import 'package:flutter/material.dart';

import '../../../common/config/color_palette.dart.dart';
import '../../../view_models/splash_screen_model.dart';

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
      backgroundColor: AppTheme().backgroundColor,
      body: Center(
        child: Image.asset('assets/Icons/logo.png'),
      ),
    );
  }
}
