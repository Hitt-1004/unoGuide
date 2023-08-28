import 'dart:convert';
import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:dyte_client/dyteParticipant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:unoquide/common/NavbarItems/Home/home.dart';

import '../../../../ateachers/models/teacher_model.dart';
import '../../../config/shared-services.dart';
import '../../../constants/constants.dart';

// page to enter meeting id and name

class JoinMeeting extends StatefulWidget {
  JoinMeeting({Key? key, this.meetingId, this.meetingName}) : super(key: key);

  String? meetingId;
  String? meetingName;

  @override
  State<JoinMeeting> createState() => _JoinMeetingState();
}

class _JoinMeetingState extends State<JoinMeeting> {
  final TextEditingController _meetingName = TextEditingController();
  final TextEditingController _meetingId = TextEditingController();

  bool isLoading = true;
  bool isErroredState = false;
  bool isSearching = false;

  String participantName = "";
  String authToken = "";

  @override
  void initState() {
    super.initState();
    // Join directly if meeting id and name is from notification click
    if (widget.meetingId != null && widget.meetingName != null) {
      _meetingId.text = widget.meetingId!;
      _meetingName.text = widget.meetingName!;
    }
  }

  //function to get auth token from dyte api
  void getAuthToken(roomId) async {
    String url =
        "https://api.cluster.dyte.in/v1/organizations/fa2aeb12-2cf4-44e6-a3bd-b7dc513789ec/meetings/${roomId}/participant";
    Map<String, dynamic> body = <String, dynamic>{};

    String currUserType = await getUserTypeFromGlobal();

    if (currUserType == "teacher") {
      TeacherDataModel teacherDataModel = await getTeacherFromGlobal();
      body["clientSpecificId"] = teacherDataModel.id;
      body["roleName"] = "participant";
      body["userDetails"] = <String, String>{
        "name": "${teacherDataModel.firstName} ${teacherDataModel.lastName}",
        "picture": teacherDataModel.image.location.toString()
      };
    }

    var response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "313bbfa362e9b227dcbf",
      },
      body: jsonEncode(body),
    );

    var data = jsonDecode(response.body);

    setState(() {
      authToken = data["data"]["authResponse"]["authToken"];
    });
  }

  @override
  void dispose() {
    _meetingId.dispose();
    _meetingName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TeacherClassProvider>(context, listen: false);

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: height * .15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Join Meeting',
              style: TextStyle(
                fontSize: 30,
                fontWeight: bold,
                fontFamily: 'Raleway',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            // meet id text field
            Container(
              height: height * .15,
              width: width * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: _meetingId,
                decoration: const InputDecoration(
                  hintText: 'Enter Meeting ID',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    // fontFamily: 'Raleway',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // meet name text field
            Container(
              height: height * .15,
              width: width * .6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              child: TextFormField(
                controller: _meetingName,
                decoration: const InputDecoration(
                  hintText: 'Enter Meeting Name',
                  hintStyle: TextStyle(
                    fontSize: 20,
                    // fontFamily: 'Raleway',
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFed6c02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                if (_meetingId.text.isNotEmpty &&
                    _meetingName.text.isNotEmpty) {
                  // getting auth token from dyte api
                  getAuthToken(_meetingId.text);

                  // if meeting is already joined then leave the meeting
                  if (provider.isMeetingJoined) {
                    provider.self.leaveRoom();
                    provider.setMeetingJoined(false);
                  }
                  // if meeting is not joined then check if auth token is not empty
                  if (authToken != "" || provider.meetingToken != "") {
                    // if auth token is not empty then set auth token and room id and name in provider
                    if (provider.meetingToken == "") {
                      provider.setDyteMeeingAuthToken(authToken);
                    }
                    provider.setRoomIdandRoomName(
                      _meetingId.text,
                      _meetingName.text,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DyteMeetingPage(),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Please enter meeting id and name"),
                    ),
                  );
                }
              },
              child: SizedBox(
                height: height * .07,
                width: width * .2,
                child: const Center(
                  child: Text(
                    'Join Meeting',
                    style: TextStyle(
                      fontSize: 20,
                      // fontWeight: bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// page to join video meeting interface

class DyteMeetingPage extends StatefulWidget {
  const DyteMeetingPage({
    Key? key,
  }) : super(key: key);

  @override
  _DyteMeetingPageState createState() => _DyteMeetingPageState();
}

class _DyteMeetingPageState extends State<DyteMeetingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final provider = Provider.of<TeacherClassProvider>(context, listen: false);

    Future<bool> _handleWillPop() async {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit an meeting?'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('No'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () {
                  provider.self.leaveRoom();
                  provider.setMeetingJoined(false);
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );

      return false;
    }

    if (provider.meetingToken == "") {
      return JoinMeeting();
    }
    return WillPopScope(
      onWillPop: () => _handleWillPop(),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: height - 100,
              width: width - 100,
              child: DyteMeeting(
                showSetupScreen: true,

                orgId: "fa2aeb12-2cf4-44e6-a3bd-b7dc513789ec",
                // get dyte room id from provider
                roomName: provider.roomName,
                // get dyte auth token from provider
                authToken: provider.meetingToken,
                onInit: (DyteMeetingHandler meeting) async {
                  var self = await meeting.self;
                  meeting.events.on('meetingConnected', this, (ev, cont) {
                    provider.setDyteSelfParticipant(self);
                    provider.setMeetingJoined(true);
                  });

                  meeting.events.on('meetingDisconnected', this, (ev, cont) {});

                  meeting.events.on('meetingEnd', this, (ev, cont) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));

                    provider.setMeetingJoined(false);
                  });

                  meeting.events.on('participantJoin', this, (ev, cont) {
                    DyteParticipant p = ev.eventData as DyteParticipant;
                  });
                  meeting.events.on('participantLeave', this, (ev, cont) {
                    DyteParticipant p = ev.eventData as DyteParticipant;
                    Navigator.pop(context);
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
