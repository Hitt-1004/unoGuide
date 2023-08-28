import 'package:flutter/material.dart';
import 'package:unoquide/services/Result.dart';

import '../../../config/shared-services.dart';
import '../../../services/createSubList.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  String? schoolLogo, admNo, schoolId, authToken;
  bool isLoading = true;
  List<Map<String, dynamic>> result = [], studentRecords = [], subList = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> init() async {
    schoolId = await getSchoolIdFromGlobal();
    admNo = await getAdmNoFromGlobal();
    authToken = await getTokenFromGlobal();
    setState(() {}); // Trigger a rebuild after fetching the values
  }

  @override
  void initState(){
    super.initState();
    init();
    // isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          FutureBuilder(
              future: fetchReport(admNo!, schoolId!, authToken!),
              builder: (context, snapshot) {
                result = List<Map<String, dynamic>>.from(snapshot.data!);
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Display a loading indicator while waiting for the data
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  // Handle the error if there is any
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  // result = List<Map<String, dynamic>>.from(
                  //     snapshot.data as List<dynamic>);
                  return Expanded(
                    child: ListView.builder(
                      itemCount: result.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (BuildContext context, int index) {
                        studentRecords = List<Map<String, dynamic>>.from(result[index]['studentRecords']);
                        subList = createSubList(studentRecords);
                        return Card(
                          color: Colors.white,
                          elevation: 5,
                          child: Column(
                            children: [
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Test Name: ${studentRecords[0]['testName']}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Text("Roll No: ${studentRecords[0]['rollNO']}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),),
                                  Text("Adm No: ${studentRecords[0]['addNo']}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold
                                    ),),
                                ],
                              ),
                              const SizedBox(height: 5,),
                              ListView.builder(
                                  itemCount: subList.length,
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(title: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(subList[index]['sub']),
                                        Text("${subList[index]['marks']}")
                                      ],
                                    ),);
                                  })
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                return Container();
              }
          ),
        ],
      ),
    );
  }
}
