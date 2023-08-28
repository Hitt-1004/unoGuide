import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/NavbarItems/Connect/VideoConference/create_meeting.dart';

import '../../../constants/constants.dart';
import 'joinMeeting.dart';

// Video Conference screen -> root screen for Join Meeting and Create Meeting

class VideoConference extends StatefulWidget {
  const VideoConference({Key? key}) : super(key: key);

  @override
  State<VideoConference> createState() => _VideoConferenceState();
}

class _VideoConferenceState extends State<VideoConference> {
  String userType = "student";
  @override
  void initState() {
    super.initState();
    getUserTypeFromGlobal().then((value) {
      setState(() {
        userType = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .16,
          ),
          const Text(
            "Video Conference",
            style: TextStyle(
                fontSize: 40, fontWeight: bold, fontFamily: 'Raleway'),
          ),
          const SizedBox(
            height: 75,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // join meeting button for both teachers and students
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => JoinMeeting(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  height: 130,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    color: Color(0xA1264653),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 4,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Join Meeting",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: bold,
                          fontFamily: 'Raleway'),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 50,
              ),
              // create meeting button onlu for teachers
              Visibility(
                visible: userType == "teacher" ? true : false,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const CreateMeeting(),
                      ),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 130,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Color(0xA1264653),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 4,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Create Meeting",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: bold,
                            fontFamily: 'Raleway'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
