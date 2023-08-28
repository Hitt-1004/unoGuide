import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:unoquide/common/NavbarItems/Home/home.dart';

class ReportCardScreen extends StatefulWidget {
  const ReportCardScreen({super.key});

  @override
  State<ReportCardScreen> createState() => _ReportCardScreenState();
}

class _ReportCardScreenState extends State<ReportCardScreen> {
  List studentRecords = [];

  Future<List<dynamic>> getMarksheetList(
      String classId, String schoolId) async {
    Map<String, String> headers = <String, String>{};

    getTokenFromGlobal().then((value) => {
          headers["Authorization"] = "Bearer $value",
        });

    final uri = Uri.parse(
      "$baseURL/teacher/records",
    );

    final response = await http.post(uri, body: {
      "classId": classId,
      "id": schoolId,
    });

    var data = jsonDecode(response.body);
    print(
        "response from report card:${data.map((e) => e["studentRecords"]).toList()}");

    List<dynamic> someData = data.map((e) => e["studentRecords"]).toList();
    return someData;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final provider = Provider.of<TeacherClassProvider>(context);
    return Container(
      color: Colors.transparent,
      child: FutureBuilder<List<dynamic>>(
        future: getMarksheetList(provider.classId, provider.schoolId),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            const Center(
              child: Text("Something went wrong"),
            );
          }

          return Padding(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.15,
                ),
                const Text(
                  "Report Card",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return snapshot.data![index].isEmpty
                          ? const Center(
                              child: Text("No Record Found"),
                            )
                          : reportCard(snapshot.data![index], size);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget reportCard(e, Size size) {
    Map subs = {};
    print("e student report card:${e[0]}");
    void getKeys() {
      e[0].forEach((key, value) {
        if (key != "firstname" &&
            key != "lastname" &&
            key != "addNo" &&
            key != "testName") {
          subs[key] = value;
        }
      });
    }

    getKeys();
    return Container(
        // width: size.width * 0.2,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 226, 244, 246),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name: ${e[0]["firstname"]} ${e[0]["lastname"]}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Add No: ${e[0]["addNo"].toString()}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Test Name: ${e[0]["testName"].toString()}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: subs.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return studentSubjectMarks(
                    subs.keys.toList()[index], subs.values.toList()[index]);
              },
            ),
          ],
        ));
  }

  Widget studentSubjectMarks(subName, marks) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$subName",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              Text(
                "$marks",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
