import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/constants/constants.dart';

import 'package:http/http.dart' as http;

import '../NavbarItems/Connect/VideoConference/joinMeeting.dart';
import 'package:unoquide/ateachers/models/teacher_model.dart' as teacherModel;

class DisplayAllNotifications extends StatefulWidget {
  const DisplayAllNotifications({super.key});

  @override
  State<DisplayAllNotifications> createState() =>
      _DisplayAllNotificationsState();
}

class _DisplayAllNotificationsState extends State<DisplayAllNotifications> {
  List<teacherModel.Notification> teacherNotifications = [];

  @override
  void initState() {
    super.initState();
    setState(() {});
    getTeacherFromGlobal().then((value) {
      print("notifications ${value.notifications}");
      setState(() {
        teacherNotifications = value.notifications;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    setState(() {});
    return teacherNotifications.isEmpty
        ? const Center(
            child: Text('No notifications'),
          )
        : Padding(
            padding: EdgeInsets.only(top: size.height * 0.15),
            child: Column(
              children: [
                const Text(
                  "Notifications",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SendToClassPage()));
                        });
                      },
                      child: SendNotificationButton(
                          size: size, text: "Send to Class"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SendToAllPage()));
                        });
                      },
                      child: SendNotificationButton(
                          size: size, text: "Send to All"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: teacherNotifications.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        color: backgroundColor,
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey, width: 0.2),
                        ),
                        child: ListTile(
                            title: Text(
                                teacherNotifications[index].title.toString()),
                            subtitle: Text(
                                teacherNotifications[index].text.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                teacherNotifications[index].meetingId != null
                                    ? ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.teal,
                                          foregroundColor: Colors.white,
                                        ),
                                        onPressed: () {
                                          // navigate to meeting page

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      JoinMeeting(
                                                        meetingId:
                                                            teacherNotifications[
                                                                    index]
                                                                .meetingId,
                                                        meetingName:
                                                            teacherNotifications[
                                                                    index]
                                                                .meetingName,
                                                      )));
                                        },
                                        icon: const Icon(
                                          Icons.room_service,
                                          size: 18,
                                        ),
                                        label: const Text("Join"))
                                    : Container(),
                                const SizedBox(
                                  width: 10,
                                ),
                                ElevatedButton.icon(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 207, 35, 23),
                                      foregroundColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        String notificationId =
                                            teacherNotifications[index].id;
                                        String teacherId =
                                            Provider.of<TeacherClassProvider>(
                                                    context,
                                                    listen: false)
                                                .teacherId;
                                        deleteNotification(
                                            notificationId, teacherId, index);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 18,
                                    ),
                                    label: const Text("Delete")),
                              ],
                            )),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }

  void deleteNotification(notificationId, teacherId, index) async {
    final url =
        Uri.parse('$baseURL/notification/deleteMyNotification/$notificationId');
    String token = await getTokenFromGlobal();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    String role = await getUserTypeFromGlobal();

    var res = await http.delete(url,
        headers: headers,
        body: jsonEncode({"userId": teacherId, "role": role}));

    if (res.statusCode == 200) {
      setState(() {
        teacherNotifications.removeAt(index);
      });
      Fluttertoast.showToast(
          msg: "Notification deleted", backgroundColor: Colors.teal);
    } else {
      Fluttertoast.showToast(msg: "Error deleting notification");
    }
  }
}

class SendNotificationButton extends StatelessWidget {
  const SendNotificationButton({
    super.key,
    required this.size,
    required this.text,
  });

  final Size size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.10,
      width: size.width * 0.2,
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class SendToClassPage extends StatelessWidget {
  const SendToClassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class SendToAllPage extends StatefulWidget {
  const SendToAllPage({super.key});

  @override
  State<SendToAllPage> createState() => _SendToAllPageState();
}

class _SendToAllPageState extends State<SendToAllPage> {
  String title = "";
  String text = "";

  void sendToAll(
      String title, String text, String schoolId, String teacherId) async {
    String role = await getUserTypeFromGlobal();

    String token = await getTokenFromGlobal();

    Map<String, String> headers = <String, String>{
      "Authorization": "Bearer $token",
      "Content-Type": "application/json"
    };

    final url =
        Uri.parse('$baseURL/notification/sendToAll/$schoolId?role=$role');
    print("url $url");
    print("text $text");
    print("title $title");
    Map<String, dynamic> body = <String, dynamic>{
      "receiver_info": <String, String>{
        "title": title,
        "text": text,
      },
      "teacherId": teacherId,
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    var data = jsonDecode(response.body);
    print(data);

    if (response.statusCode == 201) {
      Fluttertoast.showToast(
          msg: "Notification Sent", backgroundColor: Colors.teal);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => DisplayAllNotifications()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Send Notifications To All",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.14,
              width: size.width * 0.8,
              child: TextField(
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: const TextStyle(fontSize: 18),
                      focusColor: Colors.black,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              // height: size.height * 0.14,
              width: size.width * 0.8,
              child: TextField(
                  onChanged: (value) {
                    setState(() {
                      text = value;
                    });
                  },
                  cursorColor: Colors.black,
                  maxLines: 5,
                  decoration: InputDecoration(
                      hintText: "Text",
                      hintStyle: const TextStyle(fontSize: 18),
                      focusColor: Colors.black,
                      fillColor: Colors.grey[300],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.grey),
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: size.height * 0.1,
              width: size.width * 0.2,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 207, 35, 23),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    // send notification
                    // check if title and text are not empty

                    if (title.isEmpty || text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Fill all fields")));
                      return;
                    }

                    String schoolId = Provider.of<TeacherClassProvider>(context,
                            listen: false)
                        .schoolId;
                    String teacherId = Provider.of<TeacherClassProvider>(
                            context,
                            listen: false)
                        .teacherId;
                    sendToAll(
                      title,
                      text,
                      schoolId,
                      teacherId,
                    );
                  },
                  child: const Text(
                    "Send",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
