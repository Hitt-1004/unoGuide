import 'package:flutter/material.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/constants/constants.dart';

import '../../../astudents/models/studentModel.dart' as st;

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  List<st.Notify>? notifications;
  @override
  void initState() {
    getStudentFromGlobal().then((value) {
      setState(() {
        notifications = value.notifications;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .16,
          ),
          const Text(
            "Notifications",
            style: TextStyle(
                color: blackColor,
                fontSize: 40,
                fontWeight: bold2,
                fontFamily: 'Raleway'),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: notifications?.length,
            itemBuilder: (BuildContext context, int index) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Text("\t\t\t\u2022 ${notifications?[index].text}\n",
                    style: const TextStyle(
                        color: blackColor,
                        fontSize: 20,
                        fontWeight: bold,
                        fontFamily: 'Raleway')),
              );
            },
          ))
        ]);
  }
}
