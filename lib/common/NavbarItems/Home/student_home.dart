import 'package:flutter/material.dart';

import '../../components/commonItems.dart';
import '../../config/shared-services.dart';
import '../../constants/constants.dart';
import '../../../astudents/models/studentModel.dart';
import '../../../astudents/services/studentData.dart';
import '../Profile/notifications.dart';
import '../Profile/statistics.dart';
import '../Subject/subjectCourses.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key, this.authToken}) : super(key: key);
  final String? authToken;

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  String? name;
  String? classs;
  String? admissionNo;
  String? picUrl;
  String token = "";

  bool loading = false;
  List<Notify> notifications = [];
  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void initState() {
    super.initState();
    getTokenFromGlobal().then((value) {
      setState(() {
        token = value;
      });
    });
    // getTokenFromGlobal().then((value) {
    //   print("value: $value");

    //   if (value != null) {
    //     getStudentData(value).then((value) {
    //       print(value.schoolName);
    //       putStudentToGlobal(student: value);
    //       setStateIfMounted(() {
    //         loading = false;
    //         name = value.firstName;
    //         classs = "${value.studentClass!.grade}${value.studentClass!.div}";
    //         admissionNo = value.admNo;
    //         picUrl = value.image!.location;

    //         notifications = value.notifications;
    //       });
    //       putStudentToGlobal(student: value);
    //     });
    //   }
    // });
    // getStudentFromGlobal().then((value) {
    //   if (value == null) return;
    //   setStateIfMounted(() {
    //     name = value.firstName;
    //     classs = "${value.studentClass!.grade}${value.studentClass!.div}";
    //     admissionNo = value.admNo;
    //     picUrl = value.image!.location;

    //     notifications = value.notifications;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 1;
    var height = MediaQuery.of(context).size.height / 1.25;
    return FutureBuilder<StudentModel>(
      future: getStudentData(token),
      builder: (BuildContext context, AsyncSnapshot<StudentModel> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error occured"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        var data = snapshot.data;
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * .16,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Hello ${data!.firstName} !",
                          style: const TextStyle(
                            color: blackColor,
                            fontFamily: 'Raleway',
                            fontWeight: bold,
                            fontSize: 40,
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 230,
                            height: 70,
                            margin: const EdgeInsets.only(top: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5CF),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "Class: ${data!.studentClass!.div}\nAdmission No: ${data!.admNo}",
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: const StatisticsContainer(
                            activity: 'Activites\nCompleted',
                            subject1: 'English',
                            subject2: 'Mathematics',
                            percentage1: 70,
                            percentage2: 80,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: height * .2,
                            width: width * .3,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8F8F866),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Text(
                                'Score 100',
                                style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: bold,
                                  fontSize: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width * .30,
                          height: height * .14,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5CF),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'Top Subjects',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: bold,
                                  fontSize: 30),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubjectCourses(
                                                screenIndex: 0,
                                              )));
                                },
                                child: Container(
                                  height: height * .16,
                                  width: width * .2,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF9B5DE5),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'English',
                                      style: TextStyle(
                                        color: blackColor,
                                        fontFamily: 'GTN',
                                        fontWeight: bold,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SubjectCourses(
                                                screenIndex: 0,
                                              )));
                                },
                                child: Container(
                                  height: height * .16,
                                  width: width * .2,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff2f53bb),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Text(
                                      'Mathematics',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: blackColor,
                                          fontFamily: 'GTN',
                                          fontWeight: bold,
                                          fontSize: 22),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Notifications(),
                              ),
                            );
                          },
                          child: Container(
                            height: height * .4,
                            width: width * .25,
                            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            decoration: BoxDecoration(
                              color: const Color(0xff2f53bb),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFFFF4D01),
                                  Color(0xFFD9D9D9),
                                ],
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Notifications',
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: 'GTN',
                                    fontWeight: bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: data!.notifications.length,
                                      padding: const EdgeInsets.all(8),
                                      itemBuilder: (context, index) {
                                        return Text(
                                          "  ✯ ${data.notifications[index].title}",
                                          style: const TextStyle(
                                            color: blackColor,
                                            fontFamily: 'GTN',
                                            fontWeight: bold,
                                            fontSize: 12,
                                          ),
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const PersonalInfo(),
                    //       ),
                    //     );
                    //   },
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(50),
                    //     child: Image.network(
                    //       picUrl ??
                    //           "https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png",
                    //       height: 120,
                    //       width: 120,
                    //       fit: BoxFit.fill,
                    //     ),
                    //   ),
                    // ),
                  ]),
              const SizedBox(
                height: 23,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: height * .8,
                    child: Column(
                      children: [
                        const Text(
                          'Progression Graph',
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'GTN',
                            fontWeight: bold,
                            fontSize: 20,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Statistics(),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5CF),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25),
                              child: Image.asset(
                                'assets/Icons/Line chart.png',
                                width: width * .4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
