import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:unoquide/t_components/display_sub_with_name.dart';
import 'package:unoquide/common/NavbarItems/Home/home.dart';
import '../../config/shared-services.dart';
import '../../../ateachers/models/teacher_model.dart';

class Notes extends StatefulWidget {
  Notes(
      {Key? key,
      required this.notes,
      required this.subjectName,
      required this.subSubjects,
      required this.mainSubject})
      : super(key: key);
  List<dynamic> notes;
  String subjectName;
  List<dynamic> subSubjects;
  Subject mainSubject;

  @override
  State<Notes> createState() => _NotesState(notes);
}

class _NotesState extends State<Notes> {
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();
  List notes = [];
  String Scho = "School Name";
  _NotesState(this.notes);
  @override
  void initState() {
    super.initState();
    // getStudentFromGlobal().then((value) => setState(() {
    //       Scho = value.schoolName;
    //     }));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print("Notes" + widget.subSubjects.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.12,
        ),
        const Center(
          child: Text(
            "Notes",
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
        widget.subSubjects.isNotEmpty
            ? Expanded(
                child: GridView.builder(
                    itemCount: widget.subSubjects.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Notes(
                                    notes: widget.subSubjects[index]["notes"],
                                    subjectName: widget.subSubjects[index]
                                        ["name"],
                                    subSubjects: widget.subSubjects[index]
                                        ["subSubjects"],
                                    mainSubject: widget.mainSubject,
                                  )));
                        },
                        child: DisplaySubWithNameWidget(
                          data: widget.subSubjects,
                          index: index,
                          id: "33",
                        ),
                      );
                    }),
              )
            : Expanded(
                child: GridView.builder(
                    itemCount: widget.notes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      int nameIndex =
                          widget.notes[index]["name"].toString().indexOf("||");
                      String name = widget.notes[index]["name"]
                          .toString()
                          .substring(nameIndex + 2);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => openPdf().cachedFromUrl(
                                    widget.notes[index]["file"]["Location"],
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2a9d8f),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 0.5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(name,
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
      ],
    );
  }

  PDF openPdf() {
    return PDF(
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: true,
        pageFling: true,
        nightMode: false,
        onPageChanged: (int? current, int? total) =>
            _pageCountController.add('${current! + 1} - $total'),
        onViewCreated: (PDFViewController pdfViewController) async {
          _pdfViewController.complete(pdfViewController);
          final int currentPage = await pdfViewController.getCurrentPage() ?? 0;
          final int? pageCount = await pdfViewController.getPageCount();
          _pageCountController.add('${currentPage + 1} - $pageCount');
        });
  }
}
