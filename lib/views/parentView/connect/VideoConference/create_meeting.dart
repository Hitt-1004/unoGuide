import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/constants/constants.dart';

import '../../../../ateachers/services/data_controller.dart';

// Create Meeting screen -> only for teachers

class CreateMeet extends StatefulWidget {
  const CreateMeet({super.key});

  @override
  State<CreateMeet> createState() => _CreateMeetState();
}

class _CreateMeetState extends State<CreateMeet> {
  // list to choose participants for meeting
  List studentNames = [];
  List teacherNames = [];
  List parentNames = [];
  List classNames = [];
  // list to store ids of selected participants
  List studentIds = [];
  List teachersIds = [];
  List parentsIds = [];
  List classIds = [];
  // list to store ids selected participants to send notification
  List selectedParents = [];
  List selectedStudents = [];
  List selectedTeachers = [];

  final TextEditingController _meetinTitle = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllparticipants();
  }

  // function to create dyte meeting
  void createDyteMeeting(String meetingTitle) async {
    Map<String, String> headers = <String, String>{
      "Content-Type": "application/json",
      "Authorization": "313bbfa362e9b227dcbf"
    };
    Map<String, dynamic> body = <String, dynamic>{
      'title': meetingTitle,
      'authorization': <String, bool>{
        'waitingRoom': false,
      }
    };
    String url =
        "https://api.cluster.dyte.in/v1/organizations/fa2aeb12-2cf4-44e6-a3bd-b7dc513789ec/meeting";
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode(body),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      String createdMeetId = data["data"]["meeting"]["id"];
      String createdRoomeName = data["data"]["meeting"]["roomName"];

      sendNotification(createdMeetId, createdRoomeName, selectedParents,
          selectedStudents, selectedTeachers);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please enter meeting title"),
        ),
      );
    }
  }

  // function to get all participants from school
  void getAllparticipants() async {
    final provider = Provider.of<TeacherClassProvider>(context, listen: false);
    String schoolId = provider.schoolId;
    String url =
        "https://backend.unoguide.in/teacher/notificationInfo/$schoolId";

    var res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      setState(() {
        studentNames = data["studentInfo"]["name"];
        studentIds = data["studentInfo"]["id"];
        teacherNames = data["teacherInfo"]["name"];
        teachersIds = data["teacherInfo"]["id"];
        parentNames = data["parentInfo"]["name"];
        parentsIds = data["parentInfo"]["id"];
        classNames = data["classInfo"]["name"];
        classIds = data["classInfo"]["id"];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text("Error fetching data"),
        ),
      );
    }
  }

  // function to show dialog to select participants
  void _showMultiSelect(List items) async {
    // dialog implementation to select participants and get their names inside [selectedNames variable]
    final List<String> selectedNames = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelect(items: items);
      },
    );
    // store ids of selected participants
    for (var i = 0; i < selectedNames.length; i++) {
      if (studentNames.contains(selectedNames[i])) {
        setState(() {
          selectedStudents
              .add(studentIds[studentNames.indexOf(selectedNames[i])]);
        });
      } else if (teacherNames.contains(selectedNames[i])) {
        setState(() {
          selectedTeachers
              .add(teachersIds[teacherNames.indexOf(selectedNames[i])]);
        });
      } else if (parentNames.contains(selectedNames[i])) {
        setState(() {
          selectedParents
              .add(parentsIds[parentNames.indexOf(selectedNames[i])]);
        });
      }
    }
  }

  // send notification to selected participants
  void sendNotification(String createdMeetId, String createdRoomeName,
      List parents, List students, List teachers) async {
    final provider = Provider.of<TeacherClassProvider>(context, listen: false);
    String schoolId = provider.schoolId;

    String role = await getUserTypeFromGlobal();
    String token = await getTokenFromGlobal();
    String url =
        "https://backend.unoguide.in/teacher/notification/$schoolId/?role=$role";
    var res = await http.post(Uri.parse(url),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "meetingName": createdRoomeName,
          "meetingId": createdMeetId,
          "teacherId": provider.teacherId,
          "parents": parents,
          "students": students,
          "teachers": teachers
        }));

    if (res.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Notification sent"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error sending notification"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    const Text(
                      'Create Meeting',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: bold,
                        fontFamily: 'Raleway',
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: height * .15,
                      width: width * .6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: TextFormField(
                        controller: _meetinTitle,
                        decoration: const InputDecoration(
                          hintText: 'Enter Meeting Title',
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFed6c02),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => createDyteMeeting(_meetinTitle.text),
                      child: SizedBox(
                        height: height * .07,
                        width: width * .2,
                        child: const Center(
                          child: Text(
                            'Create Meeting',
                            style: TextStyle(
                              fontSize: 20,
                              // fontWeight: bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * .05,
                    ),
                    studentNames.isNotEmpty &&
                        teacherNames.isNotEmpty &&
                        parentNames.isNotEmpty &&
                        classNames.isNotEmpty
                        ? Column(
                      children: [
                        const Text(
                          "Select Participants",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          spacing: 20,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  _showMultiSelect(studentNames);
                                },
                                child: const Text("Student")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  _showMultiSelect(teacherNames);
                                },
                                child: const Text("Teacher")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  _showMultiSelect(parentNames);
                                },
                                child: const Text("Parent")),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: backgroundColor,
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  _showMultiSelect(classNames);
                                },
                                child: const Text("Class")),
                          ],
                        ),
                      ],
                    )
                        : const Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
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

// dialog pop up to select participants
class MultiSelect extends StatefulWidget {
  const MultiSelect({super.key, required this.items});
  final List items;

  @override
  State<MultiSelect> createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  final List<String> selectedItems = [];
  // function to select & remove participants
  void _itemChange(String itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedItems.add(itemValue);
      } else {
        selectedItems.remove(itemValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _done() {
    Navigator.pop(context, selectedItems);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Participants"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.items
              .map((e) => CheckboxListTile(
                  value: selectedItems.contains(e),
                  title: Text(e),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (bool? isSelected) {
                    _itemChange(e, isSelected!);
                  }))
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: _done,
          child: const Text("Done"),
        ),
      ],
    );
  }
}
