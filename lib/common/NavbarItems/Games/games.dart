// import 'dart:html';

import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  State<Games> createState() => _GamesState();
}

class _GamesState extends State<Games> {
  // final IFrameElement _iframeElement = IFrameElement()
  //   ..src = 'https://ug.uno-quide.com/games';
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            gamesWidget(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.5,
                imgUrl: "assets/Images/Games/maths_01.png",
                text: 'Maths',
                onTap: () {}),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  gamesWidget(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.35,
                      imgUrl: "assets/Images/Games/maths_02.png",
                      text: 'Maths',
                      onTap: () {}),
                  gamesWidget(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.35,
                      imgUrl: "assets/Images/Games/english_01.png",
                      text: 'English',
                      onTap: () {}),
                  gamesWidget(
                      width: MediaQuery.of(context).size.height * 0.4,
                      height: MediaQuery.of(context).size.height * 0.35,
                      imgUrl: "assets/Images/Games/english_02.png",
                      text: 'English',
                      onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class gamesWidget extends StatelessWidget {
  const gamesWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.imgUrl,
      required this.text,
      required this.onTap})
      : super(key: key);
  final double height;
  final double width;
  final String imgUrl;
  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                // image: DecorationImage(
                //   image: AssetImage(imgUrl),
                //   fit: BoxFit.cover,
                // ),
                ),
            child: Image.asset(imgUrl),
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: blackColor,
                fontSize: 20,
                fontWeight: bold,
                fontFamily: 'Raleway',
                fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}
