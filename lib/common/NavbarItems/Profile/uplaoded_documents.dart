import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:unoquide/common/config/shared-services.dart';

import 'package:unoquide/ateachers/services/get_teacher_data.dart';
import 'package:flutter/src/widgets/image.dart' as img;
import 'package:unoquide/ateachers/models/teacher_model.dart' as teacherModel;

import '../../constants/constants.dart';

class MyDocuments extends StatefulWidget {
  const MyDocuments({super.key});

  @override
  State<MyDocuments> createState() => _MyDocumentsState();
}

class _MyDocumentsState extends State<MyDocuments> {
  final Completer<PDFViewController> _pdfViewController =
      Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
      StreamController<String>();
  String token = "";
  List<teacherModel.Image> documents = [];
  @override
  void initState() {
    super.initState();
    getTokenFromGlobal().then((value) {
      setState(() {
        token = value;
      });
    }).then(
      (value) {
        getTeacherData(token).then((value) {
          setState(() {
            documents = value.documents;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        const Text(
          'Documents',
          style: TextStyle(
              color: blackColor,
              fontSize: 40,
              fontWeight: bold2,
              fontFamily: 'Raleway'),
        ),
        const SizedBox(
          height: 20,
        ),
        documents.isNotEmpty
            ? Expanded(
                child: GridView.builder(
                    itemCount: documents.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      int nameIndex =
                          documents[index].key.toString().indexOf("||");
                      String name = documents[index]
                          .key
                          .toString()
                          .substring(nameIndex + 2);
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => openPdf().cachedFromUrl(
                                    documents[index].location.toString(),
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
              )
            : CircularProgressIndicator()
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
