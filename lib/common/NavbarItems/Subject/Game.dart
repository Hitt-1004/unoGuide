import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:flutter/material.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:unoquide/astudents/models/studentModel.dart';
import '../../config/shared-services.dart';
import '../../../ateachers/models/teacher_model.dart';

class GamesA extends StatefulWidget {
  GamesA({Key? key, required this.notes, required this.subjectName})
      : super(key: key);
  List<dynamic> notes = [];
  String subjectName;

  @override
  State<GamesA> createState() => _GamesAState(notes);
}

class _GamesAState extends State<GamesA> {
  List<dynamic> notes = [];
  _GamesAState(this.notes);

  @override
  Widget build(BuildContext context) {
    print("games" + notes.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.16,
        ),
        const Center(
          child: Text(
            "Games",
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
                      builder: (context) => WebV(id: notes[index]["url"])));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
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
                  child: Text(notes[index]["Name"].toString(),
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
}

class WebV extends StatelessWidget {
  const WebV({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 50, bottom: 10.0, right: 10.0),
        child: WebView(id, aspectRatio: 4 / 5));
  }
}

class GamesA1 extends StatefulWidget {
  GamesA1({Key? key, required this.notes, required this.subjectName})
      : super(key: key);
  List<Game> notes = [];
  String subjectName;

  @override
  State<GamesA1> createState() => _GamesA1State(notes);
}

class _GamesA1State extends State<GamesA1> {
  List<Game> notes = [];
  _GamesA1State(this.notes);

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
            "Games",
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
                      builder: (context) => WebV(id: notes[index].url!)));
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
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
}
