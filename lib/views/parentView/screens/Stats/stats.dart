import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:unoguide/config/shared-services.dart';
import 'package:unoguide/constants.dart';
import 'package:unoguide/services/reportCard.dart';
import 'package:unoguide/utils/common/commonItems.dart';
import 'package:unoguide/views/parentView/screens/Stats/report.dart';
import 'package:unoguide/views/parentView/screens/Stats/statistics.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key,}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {


  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  String? schoolLogo, admNo, schoolId;
  bool isLoading = true;
  List<Map<String, dynamic>> result = [], studentRecords = [], subList = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState(){
    super.initState();

    getSchoolLogoFromGlobal().then((value) { schoolLogo = value; setState(() {
      isLoading = false;
    });});
    getSchoolIdFromGlobal().then((value) {schoolId = value;});
    getAdmNoFromGlobal().then((value) { admNo = value; });
    // isLoading = false;
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
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
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/games", (route) => false),
                            icon: Image.asset('assets/Icons/games.png'),
                            color: Colors.white,
                          ),
                        ),
                        const Text('Games',
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 10,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      '$schoolLogo',
                      width: 70,
                      height: 65,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10,),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImageTextClickableContainer(
                        width: width * .3,
                        height: height * .4,
                        imgUrl: "assets/Images/Stats/report.png",
                        text: "Statistics",
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const Statistics()));
                        }),
                    ImageTextClickableContainer(
                        width: width * .3,
                        height: height * .4,
                        imgUrl: "assets/Images/Stats/draw.png",
                        text: "Report Card",
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Report()));
                        }),
                  ],
                ),
              )
                ],
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
