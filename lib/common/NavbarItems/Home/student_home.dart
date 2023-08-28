import 'package:flutter/material.dart';

import '../../../config/shared-services.dart' as config;
import '../../../services/activities.dart';
import '../../../services/createSubList.dart';
import '../../../services/reportCard.dart';
import '../../../views/parentView/screens/Stats/statisticsGraph.dart';
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
  double score = 0, subjects = 0;
  String sub1 = '', sub2 = '';
  List<Map<String, dynamic>> result = [], studentRecord = [], subjectList = [];

  bool loading = false;
  List<Notify> notifications = [];
  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  late StudentModel data;
  List<SubjectData> activities = [];

  @override
  void initState() {
    super.initState();
    // getTokenFromGlobal().then((value) {
    //   setState(() {
    //     token = value;
    //   });
    // });
    getTokenFromGlobal().then((value) {
      print("value: $value");
      token = value;
      if (value != '') {
        getStudentData(value).then((value) {
          data = value;
          print(value.schoolName);
          putStudentToGlobal(student: value);
          setStateIfMounted(() {
            loading = false;
            name = value.firstName;
            classs = "${value.studentClass!.grade}${value.studentClass!.div}";
            admissionNo = value.admNo;
            picUrl = value.image!.location;
            activityStatus(data.admNo!, data.studentClass!.id!).then((value) {activities = value; setState(() {}); });
            notifications = value.notifications;
            sub1 = value.subjects![0].subject.name!;
            sub2 = value.subjects![1].subject.name!;
            String? schoolId = value.studentClass?.school;
            config.putSchoolIdToGlobal(schoolId: schoolId);
            config.putAdmNoToGlobal(admNo: admissionNo);
            fetchResult(admissionNo!, schoolId!).then((value) {
              result = value;
              studentRecord = List<Map<String, dynamic>>.from(result[result.length-1]['studentRecords']);
              subjectList = createSubList(studentRecord);
              for(int i = 0; i < result.length; i++){
                List<Map<String, dynamic>> studentRecords = List<Map<String, dynamic>>.from(result[0]['studentRecords']);
                List<Map<String, dynamic>> subList = createSubList(studentRecords);
                int marks = 0;
                for(int k = 0; k < subList.length; k++){
                  score += subList[k]['marks'];
                  if(subList[k]['marks'] > marks){
                    sub2 = sub1;
                    marks = subList[k]['marks'];
                    sub1 = subList[k]['sub'];
                  }
                  print("no. of sub: $subjects");
                  print("curr score: $score");
                }
                subjects += subList.length;
              }
              score = score/subjects;
              print("final score: $score");
            });
          });
          putStudentToGlobal(student: value);
        });
      }
    });
    getStudentFromGlobal().then((value) {
      if (value == null) return;
      setStateIfMounted(() {
        name = value.firstName;
        classs = "${value.studentClass!.grade}${value.studentClass!.div}";
        admissionNo = value.admNo;
        picUrl = value.image!.location;

        notifications = value.notifications;
      });
    });
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
                                "Class: ${data!.studentClass!.grade} ${data!.studentClass!.div}\nAdmission No: ${data!.admNo}",
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              width: width*0.25,
                              height: height*0.4,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF0009D9), Color(0xFF5252E0)],
                                  stops: [0, 1],
                                  begin: AlignmentDirectional(0, -1),
                                  end: AlignmentDirectional(0, 1),
                                ),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                    child: Text(
                                      'Activities \ncompleted',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontWeight: bold
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height*0.3,
                                    child: ListView.builder(
                                      itemCount: activities.length,
                                      padding: EdgeInsets.zero,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (BuildContext context, int index) {
                                        return ListTile(title: Text(
                                          "${activities[index].name}   ${activities[index].percentage}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white
                                          ),));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                            child: Center(
                              child: Text(
                                'Score $score',
                                style: const TextStyle(
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
                                  child: Center(
                                    child: Text(
                                      sub1,
                                      style: const TextStyle(
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
                                  child: Center(
                                    child: Text(
                                      sub2,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
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
                                borderRadius: BorderRadius.circular(8),
                                child: SizedBox(
                                  width: width * 0.4,
                                  height: height * 0.5,
                                  child: StatisticsGraph(subList: subjectList,),
                                )
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
