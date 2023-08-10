import 'package:flutter/material.dart';
import 'package:unoquide/common/utils/routes/route_names.dart';
import 'package:unoquide/common/NavbarItems/Games/games.dart';
import 'package:unoquide/astudents/services/student_login.dart';
import 'package:unoquide/common/screens/homepage.dart';

import '../../../screens/authentication/parentLogin.dart';
import '../../../views/screens/authentication/category_login.dart';
// import '../../../views/screens/authentication/parent_login.dart';
import '../../../ateachers/services/teacher_login.dart';
import '../../../views/screens/errorScreens/error_screen.dart';
import '../../../views/screens/splash/splash.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splashScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());

      case RouteNames.errorScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorScreen());

      case RouteNames.categoryLoginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const CategoryLoginScreen());

      case RouteNames.homeScreen:
        return MaterialPageRoute(builder: (BuildContext context) => HomePage());

      case RouteNames.studentLoginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const StudentLogin());

      case RouteNames.teacherLoginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const TeacherLogin());

      case RouteNames.parentLoginScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ParentLogin());

      case RouteNames.gamesScreen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Games());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ErrorScreen());
    }
  }
}
