import 'dart:async';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class EI extends StatefulWidget {
  const EI({Key? key}) : super(key: key);

  @override
  State<EI> createState() => _EIState();
}

class _EIState extends State<EI> {
  Function onTap = (BuildContext context, String videoId, String title) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => PDFIframe(
          videoID: videoId,
          pdfUrl: title,
        )));
  };

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(body: EqCategory());
  }
}

class PDFIframe extends StatelessWidget {
  PDFIframe({Key? key, required this.videoID, required this.pdfUrl})
      : super(key: key);
  final String videoID;
  final String pdfUrl;
  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                          onPressed: () => Navigator.pushNamedAndRemoveUntil(context, "/connect", (route) => false),
                          icon: Image.asset('assets/Icons/games.png'),
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
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width * .4,
            child: PDF(
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: true,
                pageFling: true,
                nightMode: false,
                onPageChanged: (int? current, int? total) =>
                    _pageCountController.add('${current! + 1} - $total'),
                onViewCreated: (PDFViewController pdfViewController) async {
                  _pdfViewController.complete(pdfViewController);
                  final int currentPage =
                      await pdfViewController.getCurrentPage() ?? 0;
                  final int? pageCount = await pdfViewController.getPageCount();
                  _pageCountController.add('${currentPage + 1} - $pageCount');
                }).cachedFromUrl(
              pdfUrl,
              placeholder: (progress) => Center(
                child: CircularProgressIndicator(
                  value: progress,
                ),
              ),
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 4,
            width: MediaQuery.of(context).size.width * .4,
            child: YoutubePlayer(
              controller: YoutubePlayerController.fromVideoId(
                videoId: videoID,
                params: const YoutubePlayerParams(
                  mute: false,
                  loop: true,
                  showControls: true,
                  showFullscreenButton: true,
                ),
              ),
              aspectRatio: 16 / 9,
            ),
          ),
        ],
      ),
    );
  }
}

class EqCategory extends StatelessWidget {
  EqCategory({Key? key}) : super(key: key);
  final List<String> urls = [
    'assets/Images/EI/lower.jpg',
    'assets/Images/EI/middle.jpg',
    'assets/Images/EI/higher.jpg',
  ];
  final List<String> titles = ['Lower', 'Middle', 'Higher'];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Row(
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
                IconButton(onPressed: ()=>Navigator.pop(context), icon: Image.asset('assets/Icons/Undo.png'))
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
        SizedBox(
          height: height * 0.1,
        ),
        Expanded(
          child: GridView.count(
              crossAxisCount: 3,
              children: List.generate(3, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Topics(
                          category: titles[index],
                        )));
                  },
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
                              child: Image.asset(
                                urls[index],
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
                            Text(titles[index],
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
                                    fontStyle: FontStyle.italic)),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              })),
        ),
      ],
    );
  }
}

class Topics extends StatelessWidget {
  Topics({Key? key, required this.category}) : super(key: key);
  final String category;
  List<String> urls = [
    'assets/Images/EI/gratitude.jpg',
    'assets/Images/EI/stress.png',
    'assets/Images/EI/empathy.png',
    'assets/Images/EI/Anger2.jpg',
    'assets/Images/EI/AnxietyFear.jpeg',
    'assets/Images/EI/Emotions.jpeg',
  ];
  List<String> titles = [
    'Gratitude',
    'Stress',
    'Empathy',
    'Anger',
    'Anxiety and Fear',
    'Understanding Emotions'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
                  IconButton(onPressed: ()=>Navigator.pop(context), icon: Image.asset('assets/Icons/Undo.png'))
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Expanded(
            child: GridView.count(
                crossAxisCount: 3,
                children: List.generate(urls.length, (index) {
                  return InkWell(
                    onTap: () {
                      print(category);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => YoutubeAndPdfIframe(
                            subCategory: titles[index],
                            category: category,
                          )));
                    },
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
                                child: Image.asset(
                                  urls[index],
                                  height:
                                  MediaQuery.of(context).size.height * 0.5,
                                  width: MediaQuery.of(context).size.width * 0.4,
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
                                height: MediaQuery.of(context).size.height * 0.1,
                              ),
                              Text(titles[index],
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
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                })),
          ),
        ],
      ),
    );
  }
}

class YoutubeAndPdfIframe extends StatelessWidget {
  YoutubeAndPdfIframe(
      {Key? key, required this.category, required this.subCategory})
      : super(key: key);
  final String category;
  final String subCategory;

  List<String> lowerUrls = [
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/GratitudePrimary.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/StressPrimary.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Empathy.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Anger.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/fearAnxiety.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Emotions.pdf',
  ];
  List<String> middleUrls = [
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/GratitudeMiddle.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/StressMiddle.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Empathy.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Anger.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/fearAnxiety.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Emotions.pdf',
  ];
  List<String> higherUrls = [
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/GratitudeHigh.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/StressHigh.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Empathy.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Anger.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/fearAnxiety.pdf',
    'https://uno-guide-bucket-0.s3.ap-south-1.amazonaws.com/Emotions.pdf',
  ];

  final Completer<PDFViewController> _pdfViewController =
  Completer<PDFViewController>();
  final StreamController<String> _pageCountController =
  StreamController<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
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
                  IconButton(onPressed: ()=>Navigator.pop(context), icon: Image.asset('assets/Icons/Undo.png'))
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
          const SizedBox(width: 10,),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.65,
                  margin: const EdgeInsets.only(top: 50, bottom: 10.0, right: 10.0),
                  child: PDF(
                      enableSwipe: true,
                      swipeHorizontal: true,
                      autoSpacing: true,
                      pageFling: true,
                      nightMode: false,
                      onPageChanged: (int? current, int? total) =>
                          _pageCountController.add('${current! + 1} - $total'),
                      onViewCreated: (PDFViewController pdfViewController) async {
                        _pdfViewController.complete(pdfViewController);

                        final int currentPage =
                            await pdfViewController.getCurrentPage() ?? 0;
                        final int? pageCount = await pdfViewController.getPageCount();
                        _pageCountController.add('${currentPage + 1} - $pageCount');
                      }).cachedFromUrl(
                    givePdfId(category, subCategory),
                    placeholder: (progress) => Center(
                      child: CircularProgressIndicator(
                        value: progress,
                      ),
                    ),
                    errorWidget: (dynamic error) =>
                        Center(child: Text(error.toString())),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width * 0.65,
                  margin: const EdgeInsets.all(10),
                  child: WebV(
                    id: giveYtId(category, subCategory),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String givePdfId(String category, String subCategory) {
    if (category == 'Higher') {
      //   'Gratitude',
      // 'Stress',
      // 'Empathy',
      // 'Anger',
      // 'Anxiety and Fear',
      // 'Understanding Emotions'
      if (subCategory == 'Gratitude') {
        return higherUrls[0];
      } else if (subCategory == 'Stress') {
        return higherUrls[1];
      } else if (subCategory == 'Empathy') {
        return higherUrls[2];
      } else if (subCategory == 'Anger') {
        return higherUrls[3];
      } else if (subCategory == 'Anxiety and Fear') {
        return higherUrls[4];
      } else if (subCategory == 'Understanding Emotions') {
        return higherUrls[5];
      }
    } else if (category == 'Middle') {
      if (subCategory == 'Gratitude') {
        return middleUrls[0];
      } else if (subCategory == 'Stress') {
        return middleUrls[1];
      } else if (subCategory == 'Empathy') {
        return middleUrls[2];
      } else if (subCategory == 'Anger') {
        return middleUrls[3];
      } else if (subCategory == 'Anxiety and Fear') {
        return middleUrls[4];
      } else if (subCategory == 'Understanding Emotions') {
        return middleUrls[5];
      }
    } else if (category == 'Lower') {
      if (subCategory == 'Gratitude') {
        return lowerUrls[0];
      } else if (subCategory == 'Stress') {
        return lowerUrls[1];
      } else if (subCategory == 'Empathy') {
        return lowerUrls[2];
      } else if (subCategory == 'Anger') {
        return lowerUrls[3];
      } else if (subCategory == 'Anxiety and Fear') {
        return lowerUrls[4];
      } else if (subCategory == 'Understanding Emotions') {
        return lowerUrls[5];
      }
    }
    return '';
  }

  String giveYtId(String category, String subCategory) {
    if (category == 'Lower' && subCategory == 'Stress') {
      return 'https://www.youtube.com/embed/hnpQrMqDoqE';
    } else if (category == 'Lower' && subCategory == 'Anger') {
      return 'https://www.youtube.com/embed/BsVq5R_F6RA';
    } else if (category == 'Lower' && subCategory == 'Empathy') {
      return 'https://www.youtube.com/embed/5ZF9DWBqNQU';
    } else if (category == 'Lower' && subCategory == 'Understanding Emotions') {
      return 'https://www.youtube.com/embed/Uew5BbvmLks';
    } else if (category == 'Lower' && subCategory == 'Anxiety and Fear') {
      return 'https://www.youtube.com/embed/Gd-5tRMUDqg';
    } else if (category == 'Lower' && subCategory == 'Gratitude') {
      return 'https://www.youtube.com/embed/l6zL3CtYG6Q';
    } else if (category == 'Middle' && subCategory == 'Stress') {
      return 'https://www.youtube.com/embed/69MLx9m1ctQ';
    } else if (category == 'Middle' && subCategory == 'Anger') {
      return 'https://www.youtube.com/embed/BsVq5R_F6RA';
    } else if (category == 'Middle' && subCategory == 'Empathy') {
      return 'https://www.youtube.com/embed/5ZF9DWBqNQU';
    } else if (category == 'Middle' &&
        subCategory == 'Understanding Emotions') {
      return 'https://www.youtube.com/embed/Uew5BbvmLks';
    } else if (category == 'Middle' && subCategory == 'Anxiety and Fear') {
      return 'https://www.youtube.com/embed/Gd-5tRMUDqg';
    } else if (category == 'Middle' && subCategory == 'Gratitude') {
      return 'https://www.youtube.com/embed/lrHJYeAVoKU';
    } else if (category == 'Higher' && subCategory == 'Stress') {
      return 'https://www.youtube.com/embed/hnpQrMqDoqE';
    } else if (category == 'Higher' && subCategory == 'Anger') {
      return 'https://www.youtube.com/embed/BsVq5R_F6RA';
    } else if (category == 'Higher' && subCategory == 'Empathy') {
      return 'https://www.youtube.com/embed/5ZF9DWBqNQU';
    } else if (category == 'Higher' &&
        subCategory == 'Understanding Emotions') {
      return 'https://www.youtube.com/embed/Uew5BbvmLks';
    } else if (category == 'Higher' && subCategory == 'Anxiety and Fear') {
      return 'https://www.youtube.com/embed/Gd-5tRMUDqg';
    } else if (category == 'Higher' && subCategory == 'Gratitude') {
      return 'https://abcnews.go.com/video/embed?id=59996985';
    }

    return '';
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
