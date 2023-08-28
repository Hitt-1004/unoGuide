import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:flutter/material.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:unoquide/astudents/models/studentModel.dart' as studentModel;
import '../../config/shared-services.dart';
import '../../../ateachers/models/teacher_model.dart';

class RecLectures extends StatefulWidget {
  RecLectures({Key? key, required this.notes, required this.subjectName})
      : super(key: key);
  List<Activity> notes = [];
  String subjectName;

  @override
  State<RecLectures> createState() => _RecLecturesState(notes);
}

class _RecLecturesState extends State<RecLectures> {
  List<Activity> notes = [];
  String Scho = "School Name";
  _RecLecturesState(this.notes);
  @override
  void initState() {
    super.initState();
    // getStudentFromGlobal().then((value) => setState(() {
    //       Scho = value.schoolName;
    //     }));
    print(notes.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.14,
        ),
        const Center(
          child: Text(
            "Recorded Lectures",
            style: TextStyle(
                color: blackColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
          ),
        ),
        Text(
          widget.subjectName,
          style: const TextStyle(
              color: blackColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'),
        ),
        Expanded(
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this would produce 2 rows.
            crossAxisSpacing: 5.0,

            mainAxisSpacing: 5.0,
            crossAxisCount: 3,
            // Generate 100 Widgets that display their index in the List
            children: List.generate(notes.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => YoutubeI(
                            id: _getYoutubeVideoIdByURL(notes[index].video),
                          )));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://img.youtube.com/vi/${_getYoutubeVideoIdByURL(notes[index].video)}/sddefault.jpg"),
                      fit: BoxFit.fill,
                    ),
                    color: Color(0xFF2a9d8f),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(notes[index].name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway')),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  String _getYoutubeVideoIdByURL(String url) {
    String id = url.substring(url.length - 11);

    return id;
  }
}

class YoutubeI extends StatelessWidget {
  YoutubeI({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40.0, bottom: 10.0, right: 10.0),
      child: YoutubePlayer(
          controller: YoutubePlayerController.fromVideoId(
        videoId: id,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          mute: true,
          loop: true,
        ),
      )),
    );
  }
}

class RecLectures1 extends StatefulWidget {
  RecLectures1({Key? key, required this.notes, required this.subjectName})
      : super(key: key);
  List<studentModel.Activity> notes = [];
  String subjectName;

  @override
  State<RecLectures1> createState() => _RecLectures1State(notes);
}

class _RecLectures1State extends State<RecLectures1> {
  List<studentModel.Activity> notes = [];
  String Scho = "School Name";
  _RecLectures1State(this.notes);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
        ),
        const Center(
          child: Text(
            "Recorded Lectures",
            style: TextStyle(
                color: blackColor,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
          ),
        ),
        Text(
          widget.subjectName,
          style: const TextStyle(
              color: blackColor,
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Raleway'),
        ),
        Expanded(
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this would produce 2 rows.
            crossAxisSpacing: 5.0,

            mainAxisSpacing: 5.0,
            crossAxisCount: 3,
            // Generate 100 Widgets that display their index in the List
            children: List.generate(notes.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => YoutubeI(
                        id: _getYoutubeVideoIdByURL(notes[index].video!),
                      )));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://img.youtube.com/vi/${_getYoutubeVideoIdByURL(notes[index].video!)}/sddefault.jpg"),
                      fit: BoxFit.fill,
                    ),
                    color: Color(0xFF2a9d8f),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 7,
                        offset:
                        const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(notes[index].name!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway')),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  String _getYoutubeVideoIdByURL(String url) {
    String id = url.substring(url.length - 11);

    return id;
  }
}

