import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unoquide/config/shared-services.dart';
import 'package:unoquide/constants.dart';
import 'package:unoquide/services/parentData.dart';

class Payments extends StatefulWidget {
  const Payments({Key? key,}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {


  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  String? SchoolLogo = "https://img.freepik.com/free-vector/blue-wavy-forms-transparent-background_1035-6744.jpg?w=2000";
  String? name;
  String? admNo;
  DateTime? DOB;
  int? Tuition;
  int? transport;
  int? lab;
  int index = 0;
  bool isLoading = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    getIndexFromGlobal().then((value) => index = value);
    getTokenFromGlobal().then((value) => {
      getParentData(value).then((value) => {
        putParentToGlobal(parent: value),
        setStateIfMounted(() {
          SchoolLogo = value.schoolLogo.Location;
          name = "${value.children[index].firstName} ${value.children[0].lastName}";
          admNo = value.children[index].admNo;
          DOB = DateTime(value.children[index].dob.year, value.children[0].dob.month, value.children[0].dob.day);
          Tuition = value.children[index].tuitionFee;
          transport = value.children[index].transportFee;
          lab = value.children[index].labFee;
          isLoading = false;
        })
      })
    });
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 10,),
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
                          child: Text("Fee Structure",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25
                              )),
                        ),
                        const SizedBox(height: 15,),
                        const Divider(
                          height: 20,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: const TextStyle(fontWeight: FontWeight.bold),
                            "      Name                                                                     $name"),
                        const Divider(
                          height: 20,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: const TextStyle(fontWeight: FontWeight.bold),
                            "      Admission Number                                                         $admNo"),
                        const Divider(
                          height: 20,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: const TextStyle(fontWeight: FontWeight.bold),
                            "      D.O.B                                                                            ${DateFormat('dd-MM-yyyy').format(DOB!)}"),
                        const Divider(
                          height: 20,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: const TextStyle(fontWeight: FontWeight.bold),
                            "      Tuition Fee                                                                        $Tuition"),
                        const Divider(
                          height: 20,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: const TextStyle(fontWeight: FontWeight.bold),
                            "      Transport Fee                                                                   $transport"),
                        const Divider(
                          height: 20,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        Text(style: const TextStyle(fontWeight: FontWeight.bold),
                            "      Lab Fee                                                                              $lab"),
                        const Divider(
                          height: 20,
                          thickness: 4,
                          indent: 20,
                          endIndent: 0,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Material(
                              elevation: 5,
                              child: Container(
                                alignment: Alignment.center,
                                width: 60,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text("Invoice",
                                style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Material(
                              elevation: 5,
                              child: Container(
                                alignment: Alignment.center,
                                width: 60,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const Text("Pay",
                                  style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30,)
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
