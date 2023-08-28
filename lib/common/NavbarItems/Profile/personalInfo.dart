import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:unoquide/ateachers/services/get_teacher_data.dart';
import 'package:unoquide/astudents/services/studentData.dart';

import '../../components/personalitems.dart';

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  State<PersonalInfo> createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  String? name;
  String? admissionNumber;
  String? dob;
  String? fatherName;
  String? motherName;
  String? bloodGroup;
  bool loading = true;
  String token = "";

  @override
  void initState() {
    super.initState();
    getTokenFromGlobal().then((value) {
      setState(() {
        token = value;
      });
    }).then(
      (value) {
        print("token from init" + token.toString());
        getUserTypeFromGlobal().then((value) => {
          if(value == "teacher"){
            getTeacherData(token).then((value) {
          setState(() {
            name = "${value.firstName} ${value.lastName}";
            admissionNumber = value.email;
            dob = getDOB(value.dob);
            print(dob);
            // fatherName = value.parents.isNotEmpty
            //     ? "${value.parents[0].firstName} ${value.parents[0].lastName}"
            //     : "Father's Name";

            bloodGroup = value.bloodGroup;
            loading = false;
          });
        })
          } else if(value == "student"){
            getStudentData(token).then((value) => {
              setState(() {
                name = "${value.firstName} ${value.lastName}";
                admissionNumber = value.admNo;
                dob = getDOB(value.dob);
                print(dob);
                fatherName = value.parents!.isNotEmpty
                    ? "${value.parents![0].firstName} ${value.parents![0].lastName}"
                    : "Father's Name";

                bloodGroup = value.bloodGroup;
                loading = false;
              })
            })
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return loading
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                const Text(
                  'Personal Information',
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 40,
                      fontWeight: bold2,
                      fontFamily: 'Raleway'),
                ),
                const SizedBox(
                  height: 34,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 2,
                    color: blackColor,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: InfoItem(
                      textHeading: 'NAME', textDesc: name ?? "User Name"),
                ),
                InfoItem(
                    textHeading: 'Admission Number',
                    textDesc: admissionNumber ?? "Admission Number"),
                InfoItem(
                  textHeading: 'D.O.B',
                  textDesc: dob ?? "01 January 2000",
                ),
                InfoItem(
                  textHeading: 'FATHER\'S NAME',
                  textDesc: fatherName ?? "-",
                ),
                InfoItem(
                  textHeading: 'MOTHER\'S NAME',
                  textDesc: motherName ?? "-",
                ),
                InfoItem(
                    textHeading: 'BLOOD GROUP',
                    textDesc: bloodGroup ?? "Blood Group"),
                const SizedBox(
                  height: 34,
                ),
              ],
            ),
          );
  }

  getDOB(DateTime date) {
    // month to name of month
    switch (date.month) {
      case 1:
        return '${date.day} January ${date.year}';
      case 2:
        return '${date.day} February ${date.year}';
      case 3:
        return '${date.day} March ${date.year}';
      case 4:
        return '${date.day} April ${date.year}';
      case 5:
        return '${date.day} May ${date.year}';
      case 6:
        return '${date.day} June ${date.year}';
      case 7:
        return '${date.day} July ${date.year}';
      case 8:
        return '${date.day} August ${date.year}';
      case 9:
        return '${date.day} September ${date.year}';
      case 10:
        return '${date.day} October ${date.year}';
      case 11:
        return '${date.day} November ${date.year}';
      case 12:
        return '${date.day} December ${date.year}';
    }
  }
}
