import 'package:flutter/material.dart';
import 'package:unoquide/config/shared-services.dart';
import 'package:unoquide/constants.dart';
import 'package:unoquide/services/deleteNotifications.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key, required this.notifications, required this.userId}) : super(key: key);

  final List<dynamic> notifications;
  final String userId;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String authToken;

  @override
  void initState() {
    super.initState();
    getTokenFromGlobal().then((value) => authToken = value);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: Column(
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding:
                      EdgeInsetsDirectional.fromSTEB(0, 20, 0, 15),
                      child: Text(
                        'Notifications',
                        style:TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.notifications.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Row(
                            children: [
                              Expanded(
                                child: ListTile(title: Text(
                                  widget.notifications[index]['title'] ?? "No Title",
                                  style: const TextStyle(
                                      fontSize: 16,
                                    color: Colors.black
                                  ),)),
                              ),
                              IconButton(onPressed: (){
                                deleteNotification(authToken, widget.userId, widget.notifications[index]['_id']);
                                setState(() => widget.notifications.remove(widget.notifications[index]));
                                }, icon: const Icon(Icons.delete_sharp, color: Colors.red,))
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30,),
              Align(
                alignment: const AlignmentDirectional(0, -1),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.topRight,
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
              ),
              const SizedBox(width: 30,)
            ],
          ),
        ),
      );
  }
}
