import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:unoguide/models/parentModel.dart';
import 'package:flutter/widgets.dart' as Flutter;


class Notes extends StatefulWidget {
  Notes({Key? key, required this.notes, required this.subjectName})
      : super(key: key);
  List<Note> notes = [];
  String subjectName;

  @override
  State<Notes> createState() => _NotesState(notes);
}

class _NotesState extends State<Notes> {
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();
  List<Note> notes = [];
  String Scho = "School Name";
  _NotesState(this.notes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/games", (route) => false),
                            icon: Flutter.Image.asset('assets/Icons/games.png'),
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
                            icon: Flutter.Image.asset('assets/Icons/exam.png'),
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * .1,
                  // ),
                  const Center(
                    child: Text(
                      "Notes",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Center(
                    child: Text(
                      widget.subjectName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
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
                                builder: (context) => PDF(
                                        enableSwipe: true,
                                        swipeHorizontal: true,
                                        autoSpacing: true,
                                        pageFling: true,
                                        nightMode: false,
                                        onPageChanged: (int? current, int? total) =>
                                            _pageCountController
                                                .add('${current! + 1} - $total'),
                                        onViewCreated:
                                            (PDFViewController pdfViewController) async {
                                          _pdfViewController.complete(pdfViewController);
                                          final int currentPage =
                                              await pdfViewController.getCurrentPage() ??
                                                  0;
                                          final int? pageCount =
                                              await pdfViewController.getPageCount();
                                          _pageCountController
                                              .add('${currentPage + 1} - $pageCount');
                                        }).cachedFromUrl(
                                      notes[index].file.location,
                                      placeholder: (progress) => Center(
                                        child: CircularProgressIndicator(
                                          value: progress,
                                        ),
                                      ),
                                      errorWidget: (dynamic error) =>
                                          Center(child: Text(error.toString())),
                                    )));
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
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Raleway')),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30,)
          ],
        ),
      ),
    );
  }
}
