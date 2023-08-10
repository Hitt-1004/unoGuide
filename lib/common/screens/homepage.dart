import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/NavbarItems/AudioVideo/audioVideo.dart';
import 'package:unoquide/common/NavbarItems/Connect/connect.dart';
import 'package:unoquide/common/NavbarItems/EmotionalIntelligence/emotionalIntelligence.dart';
import 'package:unoquide/common/NavbarItems/Games/games.dart';
import 'package:unoquide/common/NavbarItems/Home/home.dart';
import 'package:unoquide/common/NavbarItems/Profile/myProfile.dart';
import 'package:unoquide/common/NavbarItems/Subject/subjectCourses.dart';
import 'package:unoquide/common/NavbarItems/calendar/calendar.dart';
import 'package:unoquide/common/components/commonItems.dart';
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:unoquide/ateachers/services/get_teacher_data.dart';
import 'package:unoquide/common/utils/routes/navigator.dart';
import 'package:unoquide/views/screens/ChangePassword/changePassword.dart';
import 'package:unoquide/views/screens/authentication/category_login.dart';

import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> pages = [
    const EmotionalIntelligence(),
    const Home(),
    SubjectCourses(
      screenIndex: 0,
    ),
    const Games(),
    const AudioVideo(),
    const Connect(),
    const CalendarApp(),
    const MyProfile(),
  ];
  @override
  int _selectedIndex = 1;
  String currentPage = 'Home';
  List<String> pageKeys = [
    'EQ',
    'Home',
    'SubjectCourses',
    'Games',
    'AudioVideo',
    'Connect',
    'Calender',
    'MyProfile',
  ];
  Map<String, GlobalKey<NavigatorState>> navigatorKeys = {
    'EQ': GlobalKey<NavigatorState>(),
    'Home': GlobalKey<NavigatorState>(),
    'SubjectCourses': GlobalKey<NavigatorState>(),
    'Games': GlobalKey<NavigatorState>(),
    'AudioVideo': GlobalKey<NavigatorState>(),
    'Connect': GlobalKey<NavigatorState>(),
    'Calender': GlobalKey<NavigatorState>(),
    'MyProfile': GlobalKey<NavigatorState>(),
  };
  String authToken = '';
  String userType = '';
  String schoolName = '';
  String schoolLogo = '';
  String picUrl =
      'https://w7.pngwing.com/pngs/178/595/png-transparent-user-profile-computer-icons-login-user-avatars-thumbnail.png';
  @override
  void initState() {
    super.initState();
    getLogo();
  }

  void getLogo() async {
    getUserTypeFromGlobal().then((value) {
      setState(() {
        userType = value;
      });
    }).then((_) {
      getTokenFromGlobal().then((token) async {
        if (token != null) {
          if (userType == "teacher") {
            print("user typr is teacher");
            getTeacherData(token).then((value) {
              print("tokendata is $value");
              setStateIfMounted(() {
                schoolLogo = value.schoolLogo.location;
              });
              print(schoolLogo);
            });
          } else if (userType == "student") {
            var res = http.get(Uri.parse("$baseURL/student/"), headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            });
          }
        }
      });
    });
  }

  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  bool showSidebar = true;
  bool showProfile = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return _onWillPop();
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Stack(
          children: <Widget>[
            // side bar navigation
            Positioned(
                top: MediaQuery.of(context).size.height * .14,
                left: 0,
                // bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * .85,
                  width: MediaQuery.of(context).size.width * .11,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            selectTab(0);
                          },
                          child: const RailIconImage(
                              label: 'EQ',
                              imgUrl: 'assets/Icons/brain.png',
                              size: 25),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            selectTab(1);
                          },
                          child: const RailIconImage(
                              label: 'Home',
                              imgUrl: 'assets/Icons/home.png',
                              size: 25),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            selectTab(2);
                          },
                          child: const RailIconImage(
                              label: 'Course',
                              imgUrl: 'assets/Icons/book.png',
                              size: 25),
                        ),
                        InkWell(
                          onTap: () {
                            selectTab(3);
                          },
                          child: const RailIconImage(
                              label: 'AR & Games',
                              imgUrl: 'assets/Icons/games.png',
                              size: 25),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            selectTab(4);
                          },
                          child: const RailIconImage(
                              label: 'Audio Visual\nContent',
                              imgUrl: 'assets/Icons/video.png',
                              size: 25),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            selectTab(5);
                          },
                          child: const RailIconImage(
                              label: 'Connect',
                              imgUrl: 'assets/Icons/exam.png',
                              size: 25),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            selectTab(6);
                          },
                          child: const RailIconImage(
                              label: 'Calender',
                              imgUrl: 'assets/Icons/calender.png',
                              size: 25),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        InkWell(
                          onTap: () {
                            selectTab(7);
                          },
                          child: const RailIconImage(
                              label: 'My Profile',
                              imgUrl: 'assets/Icons/profile.png',
                              size: 30),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                )),

            // display screen
            Positioned(
              top: 0,
              left: MediaQuery.of(context).size.width * .15,
              right: 18,
              bottom: 0,
              child: Stack(
                children: [
                  _buildOffstageNavigator('EQ'),
                  _buildOffstageNavigator('Home'),
                  _buildOffstageNavigator('SubjectCourses'),
                  _buildOffstageNavigator('Games'),
                  _buildOffstageNavigator('AudioVideo'),
                  _buildOffstageNavigator('Connect'),
                  _buildOffstageNavigator('Calender'),
                  _buildOffstageNavigator('MyProfile'),
                ],
              ),
            ),

            // top bar [Row] -->
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * .15,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // logo and back button
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .14,
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              selectTab(1);
                            },
                            child: Image.asset(
                              'assets/Icons/sym.png',
                              height: 45,
                              width: 45,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                _onWillPop();
                              },
                              icon: Image.asset(
                                'assets/Icons/Undo.png',
                                height: 38,
                                width: 38,
                              )),
                        ],
                      ),
                    ),
                    // schoolLogo
                    schoolLogo != ''
                        ? SizedBox(
                            height: 40,
                            width: 40,
                            child: DecoratedBox(
                                decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                    Colors.white.withOpacity(0.2),
                                    BlendMode.color),
                                image: NetworkImage(
                                  schoolLogo,
                                ),
                              ),
                            )),
                          )
                        : const Center(),
                    // profile pic
                    // top bar right corner with profile
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showProfile = !showProfile;
                        });
                      },
                      child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(picUrl ??
                              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')),
                    ),
                  ],
                ),
              ),
            ),

            //  profile options i.e. change password and logout
            Positioned(
              top: 0,
              right: 55,
              child: showProfile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePassword()));
                          },
                          child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.16,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFffdb9c),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: AutoSizeText(
                                  'Change Password',
                                  maxLines: 2,
                                  minFontSize: 12,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Raleway',
                                    fontWeight: bold,
                                    fontSize: 15,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            showLogoutDialog(context);
                            // logout(context);
                          },
                          child: Container(
                              height: 35,
                              width: MediaQuery.of(context).size.width * 0.15,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xFFffdb9c),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: AutoSizeText(
                                  'Logout',
                                  minFontSize: 12,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Raleway',
                                    fontWeight: bold,
                                    fontSize: 15,
                                  ),
                                ),
                              )),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 35,
                      width: 100,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> showLogoutDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Dialog(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 100,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Are you sure you want to logout?',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Raleway',
                          fontWeight: bold,
                          fontSize: 15,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                                height: 40,
                                width: 120,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFffdb9c),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Raleway',
                                      fontWeight: bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          InkWell(
                            onTap: () {
                              logout(context);
                            },
                            child: Container(
                                height: 40,
                                width: 120,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFffdb9c),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Raleway',
                                      fontWeight: bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  Widget _buildOffstageNavigator(String navigatorKey) {
    return Offstage(
      offstage: currentPage != navigatorKey,
      child: TabNavigator(
        navigatorKey: navigatorKeys[navigatorKey]!,
        tabItem: navigatorKey,
      ),
    );
  }

  void selectTab(int index) {
    if (index == _selectedIndex) {
      navigatorKeys[pageKeys[index]]!
          .currentState!
          .popUntil((route) => route.isFirst);
    } else {
      setStateIfMounted(() {
        _selectedIndex = index;

        currentPage = pageKeys[index];
      });
    }
  }

  logout(context) async {
    removeTokenFromGlobal();
    removeUserTypeFromGlobal();
    Provider.of<TeacherClassProvider>(context, listen: false)
        .clearAllProviderData();
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const CategoryLoginScreen()));
  }

  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab =
        !await navigatorKeys[currentPage]!.currentState!.maybePop();
    if (isFirstRouteInCurrentTab) {
      if (currentPage != 'Home') {
        selectTab(1);
        return false;
      }
    }
    return isFirstRouteInCurrentTab;
  }
}
