import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:unoguide/config/shared-services.dart';
import 'package:unoguide/screens/EI.dart';
import 'package:unoguide/screens/authentication/category_login.dart';
import 'package:unoguide/screens/authentication/parentLogin.dart';
import 'package:unoguide/screens/authentication/studentLogin.dart';
import 'package:unoguide/screens/changePassword.dart';
import 'package:unoguide/splashScreen/splashScreen.dart';
import 'package:unoguide/views/parentView/screens/AV.dart';
import 'package:unoguide/views/parentView/screens/MyProfile/myProfile.dart';
import 'package:unoguide/views/parentView/screens/Stats/stats.dart';
import 'package:unoguide/views/parentView/screens/calendar.dart';
import 'package:unoguide/views/parentView/screens/courses/subjectCourses.dart';
import 'package:unoguide/views/parentView/screens/games.dart';
import 'package:unoguide/views/parentView/screens/home.dart';
import 'package:unoguide/views/webView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'School management system',
      // initialRoute: '/splashScreen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 253, 244, 220),
        fontFamily: GoogleFonts.raleway().fontFamily,
      ),
      home: FutureBuilder<bool>(
        future: checkLoginStatus(), // Function to check login status
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // If the login status is being checked, show a loading indicator
            return const Center(child: CircularProgressIndicator());
          } else {
            // If the login status is available, navigate to the appropriate page
            final bool isLoggedIn = snapshot.data ?? false;
            return isLoggedIn ? const HomePage() : const SplashScreen();
          }
        },
      ),
      // onGenerateRoute: (settings) {
      //   if(settings.name == '/parentHomePage') {
      //     final authToken = settings.arguments as String;
      //
      //     return MaterialPageRoute(
      //       builder: (context) => HomePage(authToken: authToken),
      //     );
      //   }
      // },
      routes: {
        '/splashScreen': (context) => const SplashScreen(),
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
        //'/HomePage': (context) => const HomePage(),
      },
    );
  }
}
