import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/NavbarItems/Profile/personalInfo.dart';
import 'package:unoquide/common/NavbarItems/Profile/statistics&Report.dart';
import 'package:unoquide/common/NavbarItems/Profile/student_info_page.dart';
import 'package:unoquide/common/NavbarItems/Profile/uplaoded_documents.dart';
import '../../components/commonItems.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    late final provider = Provider.of<TeacherClassProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ImageTextClickableContainer(
              width: width * .3,
              height: height * .4,
              imgUrl: "assets/Images/Stats/personal.png",
              text: "Personal Info",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PersonalInfo()),
                );
              }),
          provider.currentUserType == "teacher"
              ? ImageTextClickableContainer(
                  width: width * .3,
                  height: height * .4,
                  imgUrl: "assets/Images/Stats/subject.png",
                  text: "Student Info",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentInfoPage()),
                    );
                  })
              : ImageTextClickableContainer(
                  width: width * .3,
                  height: height * .4,
                  imgUrl: "assets/Images/Stats/subject.png",
                  text: "Subject Info",
                  onTap: () {}),
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ImageTextClickableContainer(
              width: width * .3,
              height: height * .4,
              imgUrl: "assets/Images/Stats/documents.png",
              text: "My Documents",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyDocuments()),
                );
              }),
          ImageTextClickableContainer(
              width: width * .3,
              height: height * .4,
              imgUrl: "assets/Images/Stats/report.png",
              text: "Statistics &\nReport Card",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const StatisticsReports()),
                );
              }),
        ]),
      ],
    );
  }
}
