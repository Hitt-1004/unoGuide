import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:flutter/material.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:unoquide/common/NavbarItems/Subject/RecordedClasses.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:unoquide/astudents/models/studentModel.dart' as studentModel;
import '../../config/shared-services.dart';
import '../../../ateachers/models/teacher_model.dart';

class AnimatedVideos extends StatefulWidget {
  AnimatedVideos({Key? key, required this.notes, required this.subjectName})
      : super(key: key);
  List<Activity> notes = [];
  String subjectName;

  @override
  State<AnimatedVideos> createState() => _AnimatedVideosState(notes);
}

class _AnimatedVideosState extends State<AnimatedVideos> {
  List<Activity>? notes;
  _AnimatedVideosState(this.notes);
  @override
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.16,
        ),
        const Center(
          child: Text(
            "Animated Videos",
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
            crossAxisSpacing: 10.0,

            mainAxisSpacing: 5.0,
            crossAxisCount: 3,
            // Generate 100 Widgets that display their index in the List
            children: List.generate((notes?.length) as int, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => YoutubeI(
                            id: _getYoutubeVideoIdByURL(notes![index].video),
                          )));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://img.youtube.com/vi/${_getYoutubeVideoIdByURL(notes![index].video)}/sddefault.jpg"),
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
                  child: Text(notes![index].name,
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  String _getYoutubeVideoIdByURL(String url) {
    String id = url.substring(url.length - 11);

    return id;
  }
}

class AnimatedVideos1 extends StatefulWidget {
  AnimatedVideos1({Key? key, required this.notes, required this.subjectName})
      : super(key: key);
  List<studentModel.Activity> notes = [];
  String subjectName;

  @override
  State<AnimatedVideos1> createState() => _AnimatedVideos1State(notes);
}

class _AnimatedVideos1State extends State<AnimatedVideos1> {
  List<studentModel.Activity>? notes;
  _AnimatedVideos1State(this.notes);

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
            "Animated Videos",
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
            crossAxisSpacing: 10.0,

            mainAxisSpacing: 5.0,
            crossAxisCount: 3,
            // Generate 100 Widgets that display their index in the List
            children: List.generate((notes?.length) as int, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => YoutubeI(
                        id: _getYoutubeVideoIdByURL(notes![index].video!),
                      )));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://img.youtube.com/vi/${_getYoutubeVideoIdByURL(notes![index].video!)}/sddefault.jpg"),
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
                  child: Text(notes![index].name!,
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
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  String _getYoutubeVideoIdByURL(String url) {
    String id = url.substring(url.length - 11);

    return id;
  }
}
