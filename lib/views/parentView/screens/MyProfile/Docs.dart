import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:unoguide/config/shared-services.dart';
import 'package:unoguide/constants.dart';
import 'package:unoguide/services/parentData.dart';

class Docs extends StatefulWidget {
  const Docs({Key? key,}) : super(key: key);

  @override
  _DocsState createState() => _DocsState();
}

class _DocsState extends State<Docs> {

  int index = 0;

  setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  // String? SchoolLogo = "https://img.freepik.com/free-vector/blue-wavy-forms-transparent-background_1035-6744.jpg?w=2000";
  final StreamController<String> _pageCountController =
  StreamController<String>();
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  List<dynamic>? docs;
  bool isLoading = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    getTokenFromGlobal().then((value) => {
      getParentData(value).then((value) => {
        putParentToGlobal(parent: value),
        setStateIfMounted(() {
          // SchoolLogo = value.schoolLogo.Location;
          getIndexFromGlobal().then((value) => index = value);
          docs = value.children[index].documents;
          isLoading = false;
        })
      })
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return isLoading ? const Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 244, 220),
      body: Center(child: CircularProgressIndicator(),),)
     : Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromARGB(255, 253, 244, 220),
      body: docs!.length == 0 ? const Center(child: Text("No documents",
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20
        ),),)
      : SafeArea(
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
                            onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/games", (route) => false),
                            icon: Image.asset('assets/Icons/games.png'),
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
            // Column(
            //   children: [
            //     ClipRRect(
            //       borderRadius: BorderRadius.circular(8),
            //       child: Image.network(
            //         '$SchoolLogo',
            //         width: 70,
            //         height: 59,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Student Documents",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25
                          )),
                      const SizedBox(height: 50,),
                      Expanded(
                        child: GridView.count(
                          // Create a grid with 2 columns. If you change the scrollDirection to
                          // horizontal, this would produce 2 rows.
                          crossAxisSpacing: 5.0,

                          mainAxisSpacing: 5.0,
                          crossAxisCount: 3,
                          // Generate 100 Widgets that display their index in the List
                          children: List.generate(docs!.length, (index) {
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
                                      docs?[index].file!.location!,
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
                                child: Text(docs?[index].name! ?? "Document",
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
                      const SizedBox(width: 5,),
                    ],
                  ),
                ),
            //   ],
            // ),
            const SizedBox(width: 30,),
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
          ],
        ),
      ),
    );
  }
}
