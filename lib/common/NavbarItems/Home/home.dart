import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/NavbarItems/Home/student_home.dart';
import 'package:unoquide/common/NavbarItems/Home/teacher_home.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.authToken}) : super(key: key);
  final String? authToken;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String token = "";
  bool loading = true;
  String user = "";

  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    super.initState();

    getUserTypeFromGlobal().then((value) {
      setState(() {
        user = value;
      });
      print("UserType: $user");
    }).then((_) {
      getTokenFromGlobal().then((token) {
        print("value is $token");
        if (token != null) {
          if (user == "teacher") {
            setState(() {
              this.token = token;
              loading = false;
            });
          } else if (user == "student") {
            setState(() {
              this.token = token;
              loading = false;
            });
            print("Student Data: $token");
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 1;
    var height = MediaQuery.of(context).size.height / 1.40;
    final provider = Provider.of<TeacherClassProvider>(context, listen: false);
    provider.currentUserType = user;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : user == "teacher"
            ? TeacherHomePage(
                token: token,
                height: height,
                width: width,
                user: user,
              )
            : user == "student"
                ? StudentHome()
                : WidgetAreaTest();
  }
}

class WidgetAreaTest extends StatelessWidget {
  const WidgetAreaTest({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}
