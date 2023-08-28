import 'dart:convert';
import 'package:dyte_client/dyte.dart';
import 'package:dyte_client/dyteMeeting.dart';
import 'package:dyte_client/dyteParticipant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:http/http.dart' as http;
import 'package:unoquide/common/NavbarItems/Home/home.dart';
import 'package:unoquide/config/shared-services.dart' as config;

import '../../../../common/config/shared-services.dart';
import '../../../../common/constants/constants.dart';
import '../../../../models/parentModel.dart' as model;

// page to enter meeting id and name

class JoinMeet extends StatefulWidget {
  JoinMeet({Key? key, this.meetingId, this.meetingName}) : super(key: key);

  String? meetingId;
  String? meetingName;

  @override
  State<JoinMeet> createState() => _JoinMeetState();
}

class _JoinMeetState extends State<JoinMeet> {
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

    if (currUserType == "parent") {
      model.ParentModel parent = await config.getParentFromGlobal();
      body["clientSpecificId"] = parent.id;
      body["roleName"] = "participant";
      body["userDetails"] = <String, String>{
        "name": "${parent.firstName} ${parent.lastName}",
        "picture": parent.image.toString()
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
    return Scaffold(
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 5),
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
            const SizedBox(width: 30,),
            Expanded(
              child: SingleChildScrollView(
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
              )
            ),
            const SizedBox(width: 30,),
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
                      value: 1,
                      child: Text('Change Password'),
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
      return JoinMeet();
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
