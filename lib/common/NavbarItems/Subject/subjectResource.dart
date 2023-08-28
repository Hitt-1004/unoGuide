import 'package:flutter/material.dart';
import 'package:unoquide/ateachers/models/teacher_model.dart';
import 'package:unoquide/common/NavbarItems/Subject/Activities.dart';
import 'package:unoquide/common/NavbarItems/Subject/Notes.dart';
import 'package:unoquide/common/NavbarItems/Subject/Q&As.dart';
import 'package:unoquide/common/NavbarItems/Subject/RecordedClasses.dart';
import 'package:unoquide/astudents/models/studentModel.dart' as studentModel;

import '../../config/shared-services.dart';
import '../../constants/constants.dart';
import 'AnimatedVideos.dart';
import 'Game.dart';

class SubjectR extends StatefulWidget {
  const SubjectR({Key? key, required this.subjectData}) : super(key: key);

  final Subject subjectData;

  @override
  State<SubjectR> createState() => _SubjectRState(subjectData);
}

class _SubjectRState extends State<SubjectR> {
  Subject subjectData;
  _SubjectRState(this.subjectData);
  String SchoolName = "School Name";

  @override
  void initState() {
    // getStudentFromGlobal().then((value) => setState(() {
    //       SchoolName = value.schoolName;
    //     }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Subject Resource" + subjectData.subSubjects.toString());
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Center(
          child: Text(
            subjectData.name,
            style: const TextStyle(
                color: blackColor,
                fontSize: 40,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),

        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Notes(
                      mainSubject: subjectData,
                      notes: subjectData.notes,
                      subjectName: subjectData.name,
                      subSubjects: subjectData.subSubjects,
                    )));
          },
          child: const Text(
            '✯ Notes',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuesAns(
                      QA: subjectData.qa,
                      subjectName: subjectData.name,
                    )));
          },
          child: const Text(
            '✯ Q&As',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        //Activites
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Activites(
                      notes: subjectData.activity,
                      subjectName: subjectData.name,
                    )));
          },
          child: const Text(
            '✯ Activities',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        //Game
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GamesA(
                      notes: subjectData.game,
                      subjectName: subjectData.name,
                    )));
          },
          child: const Text(
            '✯ Games',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        //Recrded Lectures
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RecLectures(
                      notes: subjectData.recClass,
                      subjectName: subjectData.name,
                    )));
          },
          child: const Text(
            '✯ Recorded Lectures',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        // Animated Videos
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimatedVideos(
                      notes: subjectData.animatedVideo,
                      subjectName: subjectData.name,
                    )));
          },
          child: const Text(
            '✯ Animated Videos',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        const InkWell(
          child: Text(
            '✯ Assignments',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        )
      ],
    );
  }
}

class SubjectR1 extends StatefulWidget {
  const SubjectR1({Key? key, required this.subjectData}) : super(key: key);

  final studentModel.Subject subjectData;

  @override
  State<SubjectR1> createState() => _SubjectR1State(subjectData);
}

class _SubjectR1State extends State<SubjectR1> {
  studentModel.Subject subjectData;
  _SubjectR1State(this.subjectData);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        ),
        Center(
          child: Text(
            subjectData.subject.name!,
            style: const TextStyle(
                color: blackColor,
                fontSize: 40,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),

        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Notes1(
                  notes: subjectData.subject.notes!,
                  subjectName: subjectData.subject.name!,
                )));
          },
          child: const Text(
            '✯ Notes',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => QuesAns(
                  QA: subjectData.subject.qa!,
                  subjectName: subjectData.subject.name!,
                )));
          },
          child: const Text(
            '✯ Q&As',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        //Activites
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Activites1(
                  notes: subjectData.subject.activity!,
                  subjectName: subjectData.subject.name!,
                )));
          },
          child: const Text(
            '✯ Activities',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        //Game
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => GamesA1(
                  notes: subjectData.subject.game!,
                  subjectName: subjectData.subject.name!,
                )));
          },
          child: const Text(
            '✯ Games',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        //Recrded Lectures
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => RecLectures1(
                  notes: subjectData.subject.recClass!,
                  subjectName: subjectData.subject.name!,
                )));
          },
          child: const Text(
            '✯ Recorded Lectures',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        // Animated Videos
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AnimatedVideos1(
                  notes: subjectData.subject.animatedVideo!,
                  subjectName: subjectData.subject.name!,
                )));
          },
          child: const Text(
            '✯ Animated Videos',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        ),
        const InkWell(
          child: Text(
            '✯ Assignments',
            style: TextStyle(
                color: blackColor,
                fontSize: 25,
                fontWeight: bold,
                fontFamily: 'Raleway'),
          ),
        )
      ],
    );
  }
}

