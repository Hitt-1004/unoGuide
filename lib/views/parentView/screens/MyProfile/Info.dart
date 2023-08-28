import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unoquide/config/shared-services.dart';
import 'package:unoquide/constants.dart';
import 'package:unoquide/services/parentData.dart';

class Info extends StatefulWidget {
  const Info({Key? key,}) : super(key: key);

  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {


  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  String? SchoolLogo;
  String? name;
  String? admNo;
  DateTime? DOB;
  String? Father;
  int index = 0;
  String? school;
  String? bloodGroup;
  bool isLoading = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    getTokenFromGlobal().then((value) => {
      getParentData(value).then((value) => {
        putParentToGlobal(parent: value),
        getIndexFromGlobal().then((value) => index = value),
        setStateIfMounted(() {
          SchoolLogo = value.schoolLogo.Location;
          print(SchoolLogo);
          name = "${value.children[index].firstName} ${value.children[index].lastName}";
          admNo = value.children[index].admNo;
          DOB = DateTime(value.children[index].dob.year, value.children[index].dob.month, value.children[index].dob.day);
          Father = "${value.firstName} ${value.lastName}";
          school = value.schoolName;
          bloodGroup = value.children[index].bloodGroup;
          isLoading = false;
        })
      })
    });
    print("SchoolLogo: $SchoolLogo");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(SchoolLogo);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 253, 244, 220),
      body: isLoading? const Center(child: CircularProgressIndicator(),)
      : SafeArea(
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
            // Column(
            //   children: [
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(8),
            //       child: Image.network(
            //         '$SchoolLogo',
            //         width: 70,
            //         height: 59,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20,),
                    Center(
                      child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '$SchoolLogo',
                                width: 70,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                        const SizedBox(height: 10,),
                        const Center(
                          child: Text("Student Information",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                          )),
                        ),
                        const SizedBox(height: 40,),
                        const Divider(
                          height: 10,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: TextStyle(fontWeight: FontWeight.bold),
                            "      Name                                                                    $name"),
                        const Divider(
                          height: 10,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: TextStyle(fontWeight: FontWeight.bold),
                            "      Admission Number                                                        $admNo"),
                        const Divider(
                          height: 10,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: TextStyle(fontWeight: FontWeight.bold),
                            "      D.O.B                                                                          ${DateFormat('dd-MM-yyyy').format(DOB!)}"),
                        const Divider(
                          height: 10,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: TextStyle(fontWeight: FontWeight.bold),
                            "      Parent's Name                                                     $Father"),
                        const Divider(
                          height: 10,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: TextStyle(fontWeight: FontWeight.bold),
                            "      Blood Group                                                                   $bloodGroup"),
                        const Divider(
                          height: 10,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: TextStyle(fontWeight: FontWeight.bold),
                            "      School                                                                          $school"),
                        const Divider(
                          height: 10,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
            //   ],
            // ),
            const SizedBox(width: 60,),
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
                      child: Text('Change Password'),
                      value: 1,
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
