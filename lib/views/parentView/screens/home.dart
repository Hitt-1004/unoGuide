import 'package:flutter/material.dart';
import 'package:unoquide/config/shared-services.dart';
import 'package:unoquide/constants.dart';
import 'package:unoquide/models/parentModel.dart' as model;
import 'package:unoquide/services/activities.dart';
import 'package:unoquide/services/createSubList.dart';
import 'package:unoquide/services/parentData.dart';
import 'package:unoquide/services/reportCard.dart';
import 'package:unoquide/views/parentView/models/homePageModel.dart';
import 'package:unoquide/views/parentView/screens/Notifications.dart';
import 'package:unoquide/views/parentView/screens/Stats/statisticsGraph.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageModel _model;

  List<SubjectData> activities = [];
  late String id;
  late String classId;
  String? schoolId;
  double score = 0, subjects = 0;
  String? name;
  String? classs;
  String? admissionNo;
  String? child;
  String? schoolLogo = "https://img.freepik.com/free-vector/blue-wavy-forms-transparent-background_1035-6744.jpg?w=2000";
  String? sub1, sub2;
  int index = 0;
  List<model.Child>? children;
  List<dynamic> notifications = [];
  List<Map<String, dynamic>> result = [], studentRecord = [], subjectList = [];
  // List<Map<String, dynamic>> result = [];
  bool loading = true;
  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void data(){
    getTokenFromGlobal().then((value) => {
      getParentData(value).then((value) => {
        print(value.schoolName),
        putParentToGlobal(parent: value),
        setStateIfMounted(() {
          loading = false;
          classId = value.children[index].childClass.id;
          id = value.id;
          name = "${value.firstName} ${value.lastName}";
          children = value.children;
          child = value.children[index].firstName;
          classs = "${value.children[index].childClass.grade} ${value.children[index].childClass.div}";
          admissionNo = value.children[index].admNo;
          schoolId = value.children[index].childClass.school;
          schoolLogo = value.schoolLogo.Location;
          putSchoolLogoToGlobal(schoolLogo: schoolLogo);
          sub1 = value.children[index].subjects[0].subject.name;
          sub2 = value.children[index].subjects[1].subject.name;
          // print(schoolLogo);
          notifications = value.notifications;
          activityStatus(admissionNo!, classId).then((value) {activities = value; setState(() {});});
          putSchoolIdToGlobal(schoolId: schoolId);
          putAdmNoToGlobal(admNo: admissionNo);
          print(index);
          putIndexToGlobal(index: index);
          print(value.children[index]);
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
        })
      })
    });
  }

  @override
  void initState() {
    super.initState();
    _model = HomePageModel();
    getIndexFromGlobal().then((value) => {if(value != null){
      index = value}
    });
    data();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
          child: CircularProgressIndicator(),
          )
        : GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
            child: Scaffold(
              key: scaffoldKey,
              backgroundColor: const Color.fromARGB(255, 253, 244, 220),
              body: SafeArea(
                top: true,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(width: 10,),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  'assets/Icons/logo_nobg.png',
                                  width: 70,
                                  height: 59,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(onPressed: ()=>Navigator.pop(context),
                                icon: Image.asset('assets/Icons/Undo.png'),
                            iconSize: 35,)
                          ],
                        ),
                        Container(
                          width: 74,
                          height: 265,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                                  child: IconButton(
                                    onPressed: () => Navigator.pushNamed(context, '/EI'),
                                    icon: Image.asset('assets/Icons/brain.png'),
                                    color: Colors.white,
                                  ),
                                ),
                                const Text('EI',
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                                  child: IconButton(
                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/parentHomePage", (route) => false),
                                    icon: Image.asset('assets/Icons/home.png'),
                                    color: Colors.white,
                                  ),
                                ),
                                const Text('Home',
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                                  child: IconButton(
                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/courses", (route) => false),
                                    icon: Image.asset('assets/Icons/book.png'),
                                    color: Colors.white,
                                  ),
                                ),
                                const Text('Courses',
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                                    child: IconButton(
                                      onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/connect", (route) => false),
                                      icon: Image.asset('assets/Icons/games.png'),
                                      color: Colors.white,
                                    ),
                                ),
                                const Text('Connect',
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                                  child: IconButton(
                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/AV", (route) => false),
                                    icon: Image.asset('assets/Icons/video.png'),
                                    color: Colors.white,
                                  ),
                                ),
                                const Text('AV',
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                                  child: IconButton(
                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/stats", (route) => false),
                                    icon: Image.asset('assets/Icons/stats.png'),
                                    color: Colors.white,
                                  ),
                                ),
                                const Text('  Statistics/\nReport card',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                  ),),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                                  child: IconButton(
                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/calendar", (route) => false),
                                    icon: Image.asset('assets/Icons/calendar.png'),
                                    color: Colors.white,
                                  ),
                                ),
                                const Text('Calendar',
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
                                  child: IconButton(
                                    onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/myProfile", (route) => false),
                                    icon: Image.asset('assets/Icons/profile.png'),
                                    color: Colors.white,
                                  ),
                                ),
                                const Text('Profile',
                                style: TextStyle(
                                  color: Colors.white
                                ),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: Column(
                        children: [
                          const SizedBox(height: 15,),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              '$schoolLogo',
                              width: 70,
                              height: 65,
                              fit: BoxFit.cover,
                              ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          'Hello Mr.$name',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22,
                                          ),
                                        ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 10,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(40),
                                          ),
                                          child: Container(
                                            width: 190,
                                            height: 73,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF5F5C5),
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(14, 10, 0, 0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Parent: $child\nClass: $classs\nAdmission No: $admissionNo',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      showMenu(
                                                        color: backgroundColor,
                                                        context: context,
                                                        position: RelativeRect.fromLTRB(
                                                          100,
                                                          MediaQuery.of(context).size.height,
                                                          100,60
                                                        ),
                                                        items: children!.map((child) {
                                                          return PopupMenuItem(
                                                            child: Text(child.firstName, style: const TextStyle(fontWeight: bold),),
                                                            onTap: () { setState(() {
                                                              int selectedIndex = children!.indexWhere((c) => c == child);
                                                              index = selectedIndex;
                                                              print(index);
                                                            });
                                                              loading = true;
                                                              score = 0;
                                                              subjects = 0;
                                                              subjectList = [];
                                                              data();
                                                            }
                                                          );
                                                        }).toList(),
                                                      );
                                                    },
                                                    icon: const Icon(Icons.arrow_drop_down, color: Colors.black,),
                                                  )

                                                ],
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
                                            width: 175,
                                            height: 120,
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
                                                      fontSize: 12,
                                                      fontWeight: bold
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 80,
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
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(20, 30, 0, 0),
                                        child: Material(
                                          color: Colors.transparent,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30),
                                          ),
                                          child: InkWell(
                                            onTap: () => Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => Notifications(
                                                    notifications: notifications,
                                                    userId: id))),
                                            child: Container(
                                              width: 175,
                                              height: 120,
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [Color(0xFFFF4D01), Color(0xFFDF9E9E)],
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
                                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                                                    child: Text(
                                                      'Notifications',
                                                      style:TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 80,
                                                    child: ListView.builder(
                                                      itemCount: notifications.length,
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.vertical,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return ListTile(title: Text(
                                                            "✯ ${notifications[index]['title'] ?? "No Title"}",
                                                            style: const TextStyle(
                                                            fontSize: 12
                                                          ),));
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 60, 0, 0),
                                        child: Container(
                                          width: 257,
                                          height: 65,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFFD5D91B),
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: Align(
                                            alignment: const AlignmentDirectional(0, 0),
                                            child: Text(
                                              '$child\'s score: $score',
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: const AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                          child: Material(
                                            color: Colors.transparent,
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: 185,
                                              height: 37,
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF5F5C5),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              child: const Text(
                                                'Top Subjects',
                                                textAlign: TextAlign.center,
                                                style:TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
                                              child: Material(
                                                elevation: 5,
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.circular(20),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: 120,
                                                  height: 55,
                                                  decoration: BoxDecoration(
                                                    color: const Color(0xFF9B5DE5),
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  child: Text(sub1!,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold
                                                  ),),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 30,),
                                            Material(
                                              elevation: 5,
                                              color: Colors.transparent,
                                              borderRadius: BorderRadius.circular(20),
                                              child: Container(
                                                alignment: Alignment.center,
                                                width: 120,
                                                height: 55,
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF0009D9),
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                child: Text(sub2!,
                                                style: const TextStyle(fontWeight: FontWeight.bold),),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                        child: Text(
                                          'Progression Graph',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: SizedBox(
                                          width: 300,
                                          height: 200,
                                          child: StatisticsGraph(subList: subjectList,),
                                        )
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(width: 10,),
                    Align(
                      alignment: const AlignmentDirectional(0, -1),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: PopupMenuButton(
                          icon: const Icon(Icons.person, size: 50,color: Colors.black,),
                          position: PopupMenuPosition.under,
                          color: backgroundColor,
                          elevation: 5,
                          onSelected: (int index) {
                            if(index == 1){
                              Navigator.pushNamed(context, '/changePassword');
                            }
                            else if(index == 2){
                              removeTokenFromGlobal();
                              Navigator.pushNamedAndRemoveUntil(context, '/categoryLogin', (route) => false);
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            const PopupMenuItem(
                              child: Text('Change Password'),
                            value: 1,
                            ),
                            const PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: [
                                    Icon(Icons.logout_outlined),
                                    SizedBox(width: 5,),
                                    Text('Logout')
                                  ],
                                )
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 30,)
                  ],
                ),
              ),
            ),
          );
  }
}
