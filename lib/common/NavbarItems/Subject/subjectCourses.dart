import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/astudents/models/studentModel.dart' as studentModel;
import 'package:unoquide/ateachers/models/teacher_model.dart';
import 'package:unoquide/ateachers/services/get_teacher_data.dart';
import 'package:unoquide/astudents/services/studentData.dart';
import 'package:unoquide/t_components/display_sub_with_name.dart';
import 'package:unoquide/common/NavbarItems/Home/home.dart';

import 'package:unoquide/common/NavbarItems/Subject/Game.dart';
import 'package:unoquide/common/NavbarItems/Subject/RecordedClasses.dart';
import 'package:unoquide/common/NavbarItems/Subject/subjectResource.dart';
import 'package:flutter/src/widgets/image.dart' as img;

import '../../constants/constants.dart';
import 'AnimatedVideos.dart';

class SubjectCourses extends StatefulWidget {
  SubjectCourses({Key? key, required this.screenIndex}) : super(key: key);
  int screenIndex = 0;
  @override
  State<SubjectCourses> createState() => _SubjectCoursesState(screenIndex);
}

//
class _SubjectCoursesState extends State<SubjectCourses> {
  int screenIndex;
  _SubjectCoursesState(this.screenIndex);

  String authToken = '';
  String user = 'student';
  List<studentModel.Subject> listSubject = [];
  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  bool loading = true;

  @override
  void initState() {
    print("hi from subject courses");
    getTokenFromGlobal().then((value) {
      setState(() {
        authToken = value;
        loading = false;
      });
    });
    getUserTypeFromGlobal().then((value) => user = value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : user == 'student'
          ? Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: FutureBuilder<studentModel.StudentModel>(
                  future: getStudentData(authToken),
                  builder: (BuildContext context,
                      AsyncSnapshot<studentModel.StudentModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      listSubject = snapshot.data!.subjects!;
                      return GridView.count(
                        // Create a grid with 2 columns. If you change the scrollDirection to
                        // horizontal, this would produce 2 rows.
                        crossAxisSpacing: 10.0,

                        crossAxisCount: 3,
                        // Generate 100 Widgets that display their index in the List
                        children: List.generate(listSubject.length, (index) {
                          return InkWell(
                            onTap: () =>
                                onTap1(listSubject[index], context, screenIndex),
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10, right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: img.Image.network(
                                          listSubject[index].subject.image?.location as String,
                                          height: height * 0.5,
                                          width: width * 0.4,
                                          fit: BoxFit.cover,
                                        ).blurred(
                                          blur: 1,
                                          blurColor: Colors.white.withOpacity(0.5),
                                          borderRadius: BorderRadius.circular(20),
                                        )),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: height * 0.1,
                                      ),
                                      Text(listSubject[index].subject.name as String,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: blackColor,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 10.0,
                                                  color: Colors.white,
                                                  offset: Offset(1.0, 1.0),
                                                ),
                                              ],
                                              fontSize: 20,
                                              fontWeight: bold,
                                              fontFamily: 'Raleway',
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      );
                    }
                  },
                )
              ),
            ],
          )
          : Column(
            children: [
              SizedBox(
                height: height * .15,
              ),
              Expanded(
                child: FutureBuilder<TeacherDataModel>(
                  future: getTeacherData(authToken),
                  builder: (BuildContext context,
                      AsyncSnapshot<TeacherDataModel> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      final List data = snapshot.data!.subjects;
                      return GridView.builder(
                          itemCount: data.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return SubjectR(
                                  subjectData: data[index],
                                );
                              })),
                              child: DisplaySubWithNameWidget(
                                  data: data, index: index),
                            );
                          });
                    }
                  },
                ),
              ),
            ],
          );
  }

  Function onTap = (Subject subjectName, BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubjectR(
                subjectData: subjectName,
              )));
    } else if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AnimatedVideos(
                subjectName: subjectName.name,
                notes: subjectName.animatedVideo,
              )));
    } else if (index == 2) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GamesA(
                subjectName: subjectName.name,
                notes: subjectName.game,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RecLectures(
              notes: subjectName.recClass, subjectName: subjectName.name)));
    }
  };
}

Function onTap1 = (studentModel.Subject subjectName, BuildContext context, int index) {
  if (index == 0) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SubjectR1(
          subjectData: subjectName,
        )));
  } else if (index == 1) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AnimatedVideos1(
          subjectName: subjectName.subject.name!,
          notes: subjectName.subject.animatedVideo!,
        )));
  } else if (index == 2) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => GamesA1(
          subjectName: subjectName.subject.name!,
          notes: subjectName.subject.game!,
        )));
  } else {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => RecLectures1(
            notes: subjectName.subject.recClass!,
            subjectName: subjectName.subject.name!)));
  }
};
