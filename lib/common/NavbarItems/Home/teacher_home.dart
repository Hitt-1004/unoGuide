import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/config/shared-services.dart';

import '../../../ateachers/components/file_upload.dart';
import '../../../ateachers/components/report_card.dart';
import '../../constants/constants.dart';
import '../../../ateachers/models/teacher_model.dart';
import '../../../ateachers/services/get_teacher_data.dart';
import '../../screens/notification_page.dart';

class TeacherHomePage extends StatelessWidget {
  TeacherHomePage({
    Key? key,
    required this.token,
    required this.height,
    required this.width,
    required this.user,
  }) : super(key: key);

  final String token;
  final double height;
  final double width;
  final String user;

  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TeacherDataModel>(
        future: getTeacherData(token).then((value) {
          putTeacherToGlobal(teacher: value);
          final data = value;
          final classTeacher = data.classTeacher.trim();
          // print("trimming done $classTeacher");
          //  print(classTeacher.runtimeType);
          final dataAfterSplit = classTeacher.split(',');

          final classId = dataAfterSplit[1].split('"')[1].trim();
          final schoolId = dataAfterSplit[4].contains('school')
              ? dataAfterSplit[4].split('"')[1].trim()
              : dataAfterSplit[5].split('"')[1].trim();
          final grade = dataAfterSplit[2].split(":")[1].trim();
          final section =
              dataAfterSplit[3].split(":")[1].trim().split("'")[1].trim();

          final provider =
              Provider.of<TeacherClassProvider>(context, listen: false);
          provider.setClassId(classId);
          provider.setSchoolId(schoolId);
          provider.setTeacherId(data.id);
          provider.setClasses(grade, section);
          return value;
        }),
        builder:
            (BuildContext context, AsyncSnapshot<TeacherDataModel> snapshot) {
          var data = snapshot.data;

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
          final provider = Provider.of<TeacherClassProvider>(context);
          final int gradeIndex = data!.classTeacher.indexOf('grade') + 6;
          final int divIndex = data.classTeacher.indexOf('div');
          final String grade = provider.grade;
          //data.classTeacher.substring(gradeIndex, gradeIndex + 3);
          final String division = provider.section;
          // data.classTeacher.substring(divIndex + 6, divIndex + 7);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // first row
                SizedBox(
                  height: height * 0.15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText("Hello ${snapshot.data!.firstName}!",
                              style: const TextStyle(
                                  color: blackColor,
                                  fontFamily: 'Raleway',
                                  fontWeight: bold,
                                  fontSize: 34),
                              minFontSize: 18,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              width: 230,
                              margin: const EdgeInsets.only(top: 15),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F5CF),
                                borderRadius: BorderRadius.circular(20),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Class teacher: $grade-$division",
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        color: blackColor,
                                        fontFamily: 'Raleway',
                                        fontWeight: bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "Subject :",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: blackColor,
                                        fontFamily: 'Raleway',
                                        fontWeight: bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Wrap(
                                        children: data.subjects.map((e) {
                                      int lenght = data.subjects.length - 1;
                                      int lastIndex = data.subjects.indexOf(e);
                                      String comma = "";
                                      if (lastIndex != lenght) {
                                        comma = ",";
                                      }
                                      return Text(
                                        "${e.name}${comma}",
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontFamily: 'Raleway',
                                          fontWeight: bold,
                                          fontSize: 20,
                                        ),
                                      );
                                    }).toList()),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    const Text(
                                      "Classes :",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: blackColor,
                                        fontFamily: 'Raleway',
                                        fontWeight: bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: data.classes.map((e) {
                                          int lenght = data.classes.length - 1;
                                          int lastIndex =
                                              data.classes.indexOf(e);
                                          String comma = "";
                                          if (lastIndex != lenght) {
                                            comma = ",";
                                          }
                                          return Text(
                                            "${e.grade}-${e.div}${comma}",
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontFamily: 'Raleway',
                                              fontWeight: bold,
                                              fontSize: 20,
                                            ),
                                          );
                                        }).toList())
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Provider.of<TeacherClassProvider>(context,
                                      listen: false)
                                  .setClasses(grade, division);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UploadFile()),
                              );
                            },
                            child: Container(
                              height: height * 0.25,
                              width: 250,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blue,
                              ),
                              child: const Center(
                                child: AutoSizeText(
                                  "Marksheet",
                                  style: TextStyle(
                                    color: whiteColor,
                                    fontFamily: 'Raleway',
                                    fontWeight: bold,
                                    fontSize: 30,
                                  ),
                                  minFontSize: 18,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                          //Notification container
                          SizedBox(
                            height: height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const DisplayAllNotifications()),
                              );
                            },
                            child: Container(
                              height: height * 0.55,
                              width: 250,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.amber,
                              ),
                              child: Scrollbar(
                                controller: scrollController,
                                thumbVisibility: true,
                                thickness: 5,
                                interactive: true,
                                radius: const Radius.circular(20),
                                scrollbarOrientation:
                                    ScrollbarOrientation.right,
                                child: SingleChildScrollView(
                                  controller: scrollController,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: data.notifications
                                          .map((e) => Text(
                                                "•  ${e.title}",
                                                style: const TextStyle(
                                                  color: blackColor,
                                                  fontFamily: 'Raleway',
                                                  fontWeight: bold,
                                                  fontSize: 16,
                                                ),
                                              ))
                                          .toList()),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReportCardScreen()),
                    );
                  },
                  child: Container(
                    width: width * 0.7,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5CF),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "My Classes",
                          style: TextStyle(
                            color: blackColor,
                            fontFamily: 'Raleway',
                            fontWeight: bold,
                            fontSize: 30,
                          ),
                        ),
                        Wrap(
                          children: data.classes
                              .map((e) => Container(
                                    height: 150,
                                    width: 120,
                                    margin: const EdgeInsets.only(top: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: const DecorationImage(
                                            image: NetworkImage(
                                                'https://unoguide.in/static/media/Kid.07e9608ae495ef883e67.png'),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                                Colors.white24,
                                                BlendMode.lighten))),
                                    child: Center(
                                      child: Text(
                                        "${e.grade}-${e.div}",
                                        style: const TextStyle(
                                          color: blackColor,
                                          fontFamily: 'Raleway',
                                          fontWeight: bold,
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  ))
                              .toList(),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
