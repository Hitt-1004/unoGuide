import 'package:flutter/material.dart';
import 'package:unoquide/common/NavbarItems/AudioVideo/audioVideo.dart';
import 'package:unoquide/common/NavbarItems/EmotionalIntelligence/emotionalIntelligence.dart';


import '../../NavbarItems/Connect/connect.dart';
import '../../NavbarItems/Home/home.dart';
import '../../NavbarItems/Profile/myProfile.dart';
import '../../NavbarItems/Subject/subjectCourses.dart';
import '../../NavbarItems/calendar/calendar.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem})
      : super(key: key);
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;
  @override
  Widget build(BuildContext context) {
    Widget child;
    if (tabItem == 'EQ') {
      child = const EmotionalIntelligence();
    } else if (tabItem == 'Home') {
      child = Home();
    } else if (tabItem == 'SubjectCourses') {
      child = SubjectCourses(
        screenIndex: 0,
      );
    } else if (tabItem == 'AudioVideo') {
      child = const AudioVideo();
    } else if (tabItem == 'Connect') {
      child = const Connect();
    } else if (tabItem == 'Calender') {
      child = const CalendarApp();
    } else if (tabItem == 'MyProfile') {
      child = const MyProfile();
    } else if (tabItem == 'Games') {
      child = SubjectCourses(screenIndex: 2);
    } else {
      child = const Center(child: Text('Settings'));
    }
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}
