import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/utils/routes/route_names.dart';
import 'package:unoquide/common/NavbarItems/Connect/VideoConference/joinMeeting.dart';
import 'package:unoquide/common/NavbarItems/calendar/date_provider.dart';
import 'package:unoquide/views/parentView/connect/connect.dart';
import 'package:unoquide/views/screens/splash/splash.dart';

import 'common/utils/routes/routes.dart';

import 'package:unoquide/screens/EI.dart';
import 'package:unoquide/views/screens/authentication/category_login.dart';
import 'package:unoquide/screens/authentication/parentLogin.dart';
import 'package:unoquide/screens/authentication/studentLogin.dart';
import 'package:unoquide/screens/changePassword.dart';
// import 'package:unoquide/splashScreen/splashScreen.dart';
import 'package:unoquide/views/parentView/screens/AV.dart';
import 'package:unoquide/views/parentView/screens/MyProfile/myProfile.dart';
import 'package:unoquide/views/parentView/screens/Stats/stats.dart';
import 'package:unoquide/views/parentView/screens/calendar.dart';
import 'package:unoquide/views/parentView/screens/courses/subjectCourses.dart';
import 'package:unoquide/views/parentView/screens/games.dart';
import 'package:unoquide/views/parentView/screens/home.dart';
import 'package:unoquide/views/webView.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft])
      .then((_) {
    runApp(const MyApp());
  });
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TeacherClassProvider>(
            create: (_) => TeacherClassProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        initialRoute: RouteNames.splashScreen,
        onGenerateRoute: Routes.generateRoute,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color.fromARGB(255, 253, 244, 220),
          fontFamily: GoogleFonts.raleway().fontFamily,
        ),
        home: const SplashScreen(),
        routes: {
          // '/splashScreen': (context) => const SplashScreen(),
          '/webView': (context) => WebViewContainer('https://unoguide.in/login'),
          '/categoryLogin': (context) => const CategoryLoginScreen(),
          '/parentLogin': (context) => const ParentLogin(),
          '/studentLogin': (context) => const StudentLogin(),
          '/EI': (context) => const EI(),
          '/parentHomePage': (context) => const HomePage(),
          '/courses': (context) => SubjectCourses(screenIndex: 0),
          '/games': (context) => const Games(),
          '/AV': (context) => const AV(),
          '/stats': (context) => const Stats(),
          '/calendar': (context) => const CalendarApp(),
          '/myProfile': (context) => const MyProfile(),
          '/changePassword': (context) => const ChangePassword(),
          '/connect': (context) => const Connect(),
          //'/HomePage': (context) => const HomePage(),
        },
      ),
    );
  }
}
