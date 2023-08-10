import 'package:blur/blur.dart';
import 'package:flutter/widgets.dart' as Flutter;
import 'package:flutter/material.dart';
import 'package:unoquide/config/shared-services.dart';
import 'package:unoquide/constants.dart';
import 'package:unoquide/models/parentModel.dart';
import 'package:unoquide/services/parentData.dart';
import 'package:unoquide/views/parentView/screens/courses/Game.dart';
import 'package:unoquide/views/parentView/screens/courses/RecordedClasses.dart';
import 'package:unoquide/views/parentView/screens/courses/subjectResource.dart';
import 'AnimatedVideos.dart';

class SubjectCourses extends StatefulWidget {
  SubjectCourses({Key? key, required this.screenIndex}) : super(key: key);
  int screenIndex = 0;
  @override
  State<SubjectCourses> createState() => _SubjectCoursesState(screenIndex);
}

class _SubjectCoursesState extends State<SubjectCourses> {
  int screenIndex;
  _SubjectCoursesState(this.screenIndex);
  List<Subject> listSubject = [];
  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  bool loading = true;

  @override
  void initState() {
    getTokenFromGlobal().then((value) => getParentData(value).then((value) {
          getIndexFromGlobal().then((index) {
            setStateIfMounted(() {
              listSubject = value.children[index].subjects;
              loading = false;
              print("index: $index");
            });
          });
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
          body: SafeArea(
            child: Row(
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
                              child: Flutter.Image.asset(
                                'assets/Icons/logo_nobg.png',
                                width: 70,
                                height: 59,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          IconButton(onPressed: ()=>Navigator.pop(context), icon: Flutter.Image.asset('assets/Icons/Undo.png'))
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
                                  icon: Flutter.Image.asset('assets/Icons/brain.png'),
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
                                  icon: Flutter.Image.asset('assets/Icons/home.png'),
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
                                  icon: Flutter.Image.asset('assets/Icons/book.png'),
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
                                  icon: Flutter.Image.asset('assets/Icons/games.png'),
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
                                  icon: Flutter.Image.asset('assets/Icons/video.png'),
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
                                  icon: Flutter.Image.asset('assets/Icons/stats.png'),
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
                                  icon: Flutter.Image.asset('assets/Icons/calendar.png'),
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
                                  icon: Flutter.Image.asset('assets/Icons/profile.png'),
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
                  // Flutter.Column(
                  //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     const SizedBox(
                  //       height: 30,
                  //     ),
                      Expanded(
                        child: GridView.count(
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this would produce 2 rows.
                          crossAxisSpacing: 6.0,
                          crossAxisCount: 2,
                          // Generate 100 Widgets that display their index in the List
                          children: List.generate(listSubject.length, (index) {
                            return InkWell(
                              onTap: () =>
                                  onTap(listSubject[index], context, screenIndex),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 10, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(
                                                0, 3), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: Flutter.Image.network(
                                            listSubject[index].subject.image.location,
                                            height: height * 0.5,
                                            width: width * 0.4,
                                            fit: BoxFit.cover,
                                          ).blurred(
                                            blur: 1,
                                            blurColor: Colors.white.withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(20),
                                          )),
                                    ),
                                  ),
                                  Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: height * 0.1,
                                        ),
                                        Text(listSubject[index].subject.name,
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 10.0,
                                                    color: Colors.white,
                                                    offset: Offset(1.0, 1.0),
                                                  ),
                                                ],
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Raleway',
                                                fontStyle: FontStyle.italic)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ),
                      ),
                  const SizedBox(width: 5,),
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

  Function onTap = (Subject subjectName, BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SubjectR(
                subjectData: subjectName,
              )));
    } else if (index == 1) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AnimatedVideos(
                subjectName: subjectName.subject.name,
                notes: subjectName.subject.animatedVideo!,
              )));
    } else if (index == 2) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => GamesA(
                subjectName: subjectName.subject.name!,
                notes: subjectName.subject.game!,
              )));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RecLectures(
              notes: subjectName.subject.recClass!,
              subjectName: subjectName.subject.name!)));
    }
  };
}
