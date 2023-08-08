import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as Flutter;
import 'package:unoguide/models/parentModel.dart';

class GamesA extends StatefulWidget {
  GamesA({Key? key, required this.notes, required this.subjectName})
      : super(key: key);
  List<Game> notes = [];
  String subjectName;

  @override
  State<GamesA> createState() => _GamesAState(notes);
}

class _GamesAState extends State<GamesA> {
  List<Game> notes = [];
  _GamesAState(this.notes);

  @override
  Widget build(BuildContext context) {
    print("notes: ${widget.notes}");
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
                      "Games",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                  ),
                  Text(
                    widget.subjectName,
                    style: const TextStyle(
                        color: Colors.black,
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
                      children: List.generate(widget.notes.length, (index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => WebV(id: widget.notes[index].url!)));
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
                            child: Text(widget.notes[index].name!,
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
