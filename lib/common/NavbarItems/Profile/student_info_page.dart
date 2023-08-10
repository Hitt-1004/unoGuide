import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/ateachers/models/teacher_model.dart' as teacherModel;

import '../../../ateachers/services/data_controller.dart';
import '../../components/personalitems.dart';

class StudentInfoPage extends StatefulWidget {
  const StudentInfoPage({super.key});

  @override
  State<StudentInfoPage> createState() => _StudentInfoPageState();
}

class _StudentInfoPageState extends State<StudentInfoPage> {
  String?
      dropdownValueStudentName; // student name from dropdown menu eg. saurabh kumar
  String? dropdownValueClassName; // class name from dropdown menu eg. 2-a

  List<teacherModel.Class> classes = []; // list of all classes of this teacher
  List<teacherModel.Student> students =
      []; // list of all students of this class // 2-a
  List<DropdownMenuItem<String>>?
      items; // list of all students of this class // 2-a
  teacherModel.Student?
      selectedStudent; // selected student data from dropdown menu
  int selectedClassIndex = -1;

  @override
  void initState() {
    super.initState();
    getTeacherFromGlobal().then((value) {
      setState(() {
        // get all students of all the classes of this teacher
        value.classes.forEach((element) {
          students = [...students, ...element.students];
        });
        // get all classes of this teacher eg. 2-a, 2-b, 3-a, 3-b
        classes = value.classes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeacherClassProvider>(context);
    final size = MediaQuery.of(context).size;

    if (dropdownValueClassName != null) {
      // get index of selected class from dropdown menu eg. 2-a is at index 0 in json data
      selectedClassIndex = classes.indexOf(classes.firstWhere((element) {
        return "${element.grade}-${element.div}" == dropdownValueClassName;
      }));
      // get all students of selected class only from dropdown menu eg. students of 2-a only
      items = classes[selectedClassIndex]
          .students
          .map((e) => DropdownMenuItem<String>(
                value: e.id,
                child: Text("${e.firstName} ${e.lastName}"),
              ))
          .toList();
    } // ....[1]
    if (students.isNotEmpty && dropdownValueStudentName != null) {
      // get selected student details from dropdown menu eg. saurabh kumar's admission number, email, dob, blood group etc.
      selectedStudent = students.firstWhere(
          (element) => element.id == dropdownValueStudentName.toString());
    }

    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1st dropdown menu for class name
                Container(
                  alignment: Alignment.centerRight,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: size.width * 0.13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: DropdownButton<String>(
                    alignment: AlignmentDirectional.centerEnd,
                    value: dropdownValueClassName,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    borderRadius: BorderRadius.circular(10),
                    underline: Container(
                      height: 0,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValueClassName = value!;
                      });
                    },
                    items: provider.classes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                // 2nd dropdown menu for student name
                dropdownValueClassName != null
                    ? Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: size.width * 0.23,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: DropdownButton<String>(
                          alignment: AlignmentDirectional.centerEnd,
                          value: dropdownValueStudentName,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          style: const TextStyle(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(10),
                          underline: Container(
                            height: 0,
                            color: Colors.deepPurpleAccent,
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              dropdownValueStudentName = value!;
                            });
                          },
                          items: items,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            selectedStudent != null && selectedStudent!.image.location != null
                ? Image.network(
                    selectedStudent!.image.location,
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  )
                : const SizedBox(),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        selectedStudent != null
            ? Column(
                children: [
                  InfoItem(
                      textHeading: "First Name",
                      textDesc: selectedStudent!.firstName.toString()),
                  InfoItem(
                      textHeading: "Last Name",
                      textDesc: selectedStudent!.lastName.toString()),
                  InfoItem(
                      textHeading: "Admission Number",
                      textDesc: selectedStudent!.admNo.toString()),
                  InfoItem(
                      textHeading: "Email",
                      textDesc: selectedStudent!.email.toString()),
                  InfoItem(
                      textHeading: "DOB",
                      textDesc: selectedStudent!.dob.toString().split(" ")[0]),
                  InfoItem(
                      textHeading: "Blood Group",
                      textDesc: selectedStudent!.bloodGroup.toString()),
                  // InfoItem(
                  //     textHeading: "Father's Name",
                  //     textDesc: selectedStudent.parents.isNotEmpty
                  //         ? "${selectedStudent.parents[0]}}"
                  //         : "Father's Name"),
                  // InfoItem(
                  //     textHeading: "Mother's Name",
                  //     textDesc: selectedStudent.parents.isNotEmpty
                  //         ? "${selectedStudent.parents[0]}}"
                  //         : "Mother's Name"),
                ],
              )
            : const SizedBox(),
      ]),
    );
  }
}
