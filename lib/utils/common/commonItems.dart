import 'package:flutter/material.dart';

import '../../constants.dart';

class RailIconImage extends StatelessWidget {
  const RailIconImage(
      {Key? key, required this.label, required this.imgUrl, required this.size})
      : super(key: key);
  final String imgUrl;
  final double size;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          imgUrl,
          color: Colors.white,
          height: size,
          width: size,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 8),
        ),
      ],
    );
  }
}

class ImageTextClickableContainer extends StatelessWidget {
  const ImageTextClickableContainer(
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
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imgUrl),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: blackColor,
                fontSize: 20,
                fontWeight: bold,
                fontFamily: 'Raleway',
                fontStyle: FontStyle.italic),
          ),
        ),
      ),
    );
  }
}

class StatisticsContainer extends StatelessWidget {
  const StatisticsContainer(
      {Key? key,
      required this.activity,
      required this.subject1,
      required this.subject2,
      required this.percentage1,
      required this.percentage2})
      : super(key: key);
  final String activity;
  final String subject1;
  final String subject2;
  final int percentage1;
  final int percentage2;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
        height: height * .33,
        width: width * .24,
        margin: const EdgeInsets.fromLTRB(10, 40, 20, 0),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F866),
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF236BCA),
              Color(0xff0009d900),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              activity,
              style: TextStyle(
                color: whiteColor,
                fontFamily: 'GTN',
                fontWeight: bold,
                fontSize: 15,
              ),
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "$percentage1%",
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'GTN',
                    fontWeight: bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/Icons/piechart.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  subject1,
                  style: TextStyle(
                    color: whiteColor,
                    fontFamily: 'GTN',
                    fontWeight: bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "$percentage2%",
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: 'GTN',
                    fontWeight: bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(
                  'assets/Icons/piechart.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  subject2,
                  style: TextStyle(
                    color: whiteColor,
                    fontFamily: 'GTN',
                    fontWeight: bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
