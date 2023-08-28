import 'package:flutter/material.dart';
import 'package:unoquide/services/Result.dart';

import '../../../config/shared-services.dart';
import '../../../services/createSubList.dart';
import '../../../views/parentView/screens/Stats/statisticsGraph.dart';
import '../../components/commonItems.dart';
import '../../constants/constants.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
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
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: height * .16,
          ),
          const Text(
            'Statistics',
            style: TextStyle(
                color: blackColor,
                fontSize: 40,
                fontWeight: bold3,
                fontFamily: 'Raleway'),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: FutureBuilder(
                future: fetchReport(admNo!, schoolId!, authToken!),
                builder: (context, snapshot) {
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
                    result = List<Map<String, dynamic>>.from(snapshot.data!);
                    print(result);
                    if(result != []){
                      studentRecords = List<Map<String, dynamic>>.from(result[0]['studentRecords']);
                      subList = createSubList(studentRecords);
                      return  ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: width * 0.4,
                            height: height * 0.5,
                            child: StatisticsGraph(subList: subList,),
                          )
                      );
                    }
                    return const Center(child: StatisticsGraph(subList: [],),);
                  }
                  return Container();
                }
            ),),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
