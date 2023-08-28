import 'dart:async';

import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:provider/provider.dart';
import 'package:unoquide/ateachers/services/data_controller.dart';
import 'package:unoquide/common/constants/constants.dart';
import 'package:unoquide/common/NavbarItems/Subject/Game.dart';
import 'package:unoquide/common/NavbarItems/Subject/RecordedClasses.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class EmotionalIntelligence extends StatefulWidget {
  const EmotionalIntelligence({Key? key}) : super(key: key);

  @override
  State<EmotionalIntelligence> createState() => _EmotionalIntelligenceState();
}

class _EmotionalIntelligenceState extends State<EmotionalIntelligence> {
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
    return EqCategory();
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
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
          height: MediaQuery.of(context).size.height * 0.5,
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
    );
  }
}

class EqCategory extends StatelessWidget {
  EqCategory({Key? key}) : super(key: key);
  final List<String> urls = [
    'assets/Images/EmotionalIntelligence/lower.jpg',
    'assets/Images/EmotionalIntelligence/middle.jpg',
    'assets/Images/EmotionalIntelligence/higher.jpg',
  ];
  final List<String> titles = ['Primary', 'Middle', 'Higher'];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final provider = Provider.of<TeacherClassProvider>(context);
    print("provider.isMiddle ${provider.isMiddle}");
    return Column(
      children: [
        SizedBox(
          height: height * .15,
        ),
        Expanded(
          child: provider.isMiddle == 'Lower'
              ? InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Topics(
                              category: titles[0],
                            )));
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: Center(
                          child: Container(
                            height: height * 0.5,
                            width: width * 0.4,
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
                                image: DecorationImage(
                                    image: AssetImage(
                                      urls[0],
                                    ),
                                    filterQuality: FilterQuality.low,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.4),
                                        BlendMode.dstATop),
                                    fit: BoxFit.cover)),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: height * 0.1,
                                  ),
                                  Text(titles[0],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: blackColor,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10.0,
                                              color: Colors.white,
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                          fontSize: 20,
                                          fontWeight: bold,
                                          fontFamily: 'Raleway',
                                          fontStyle: FontStyle.italic)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : provider.isMiddle == 'Middle'
                  ? InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Topics(
                                  category: titles[1],
                                )));
                      },
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            child: Center(
                              child: Container(
                                height: height * 0.5,
                                width: width * 0.4,
                                margin:
                                    const EdgeInsets.only(top: 10, right: 10),
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
                                    image: DecorationImage(
                                        image: AssetImage(
                                          urls[1],
                                        ),
                                        filterQuality: FilterQuality.low,
                                        colorFilter: ColorFilter.mode(
                                            Colors.black.withOpacity(0.4),
                                            BlendMode.dstATop),
                                        fit: BoxFit.cover)),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: height * 0.1,
                                      ),
                                      Text(titles[1],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: blackColor,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 10.0,
                                                  color: Colors.white,
                                                  offset: Offset(1.0, 1.0),
                                                ),
                                              ],
                                              fontSize: 20,
                                              fontWeight: bold,
                                              fontFamily: 'Raleway',
                                              fontStyle: FontStyle.italic)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : provider.isMiddle == 'Higher'
                      ? InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Topics(
                                      category: titles[2],
                                    )));
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                child: Center(
                                  child: Container(
                                    height: height * 0.5,
                                    width: width * 0.4,
                                    margin: const EdgeInsets.only(
                                        top: 10, right: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 5,
                                            blurRadius: 7,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        image: DecorationImage(
                                            image: AssetImage(
                                              urls[2],
                                            ),
                                            filterQuality: FilterQuality.low,
                                            colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.4),
                                                BlendMode.dstATop),
                                            fit: BoxFit.cover)),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.1,
                                          ),
                                          Text(titles[2],
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: blackColor,
                                                  shadows: [
                                                    Shadow(
                                                      blurRadius: 10.0,
                                                      color: Colors.white,
                                                      offset: Offset(1.0, 1.0),
                                                    ),
                                                  ],
                                                  fontSize: 20,
                                                  fontWeight: bold,
                                                  fontFamily: 'Raleway',
                                                  fontStyle: FontStyle.italic)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
            children: [
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
                                          color: blackColor,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 10.0,
                                              color: Colors.white,
                                              offset: Offset(1.0, 1.0),
                                            ),
                                          ],
                                          fontSize: 20,
                                          fontWeight: bold,
                                          fontFamily: 'Raleway',
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
        ),
      ],
    );
  }
}

class Topics extends StatelessWidget {
  Topics({Key? key, required this.category}) : super(key: key);
  final String category;
  List<String> urls = [
    'assets/Images/EmotionalIntelligence/gratitude.jpg',
    'assets/Images/EmotionalIntelligence/stress.png',
    'assets/Images/EmotionalIntelligence/empathy.png',
    'assets/Images/EmotionalIntelligence/Anger2.jpg',
    'assets/Images/EmotionalIntelligence/AnxietyFear.jpeg',
    'assets/Images/EmotionalIntelligence/Emotions.jpeg',
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
    return Column(
      children: [
        Expanded(
          child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(10),
              children: List.generate(urls.length, (index) {
                return Visibility(
                  child: InkWell(
                    onTap: () {
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
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
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                              ),
                              Text(titles[index],
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: blackColor,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 10.0,
                                          color: Colors.white,
                                          offset: Offset(1.0, 1.0),
                                        ),
                                      ],
                                      fontSize: 20,
                                      fontWeight: bold,
                                      fontFamily: 'Raleway',
                                      fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ),
      ],
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 2,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 00, bottom: 10.0, right: 10.0),
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
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            child: WebV(
              id: giveYtId(category, subCategory),
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
