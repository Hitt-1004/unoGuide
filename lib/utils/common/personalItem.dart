import 'package:flutter/material.dart';

import '../../constants.dart';

class InfoItem extends StatelessWidget {
  InfoItem({Key? key, required this.textHeading, required this.textDesc})
      : super(key: key);
  String textHeading;
  String textDesc;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(textHeading,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 20,
                      fontWeight: bold,
                      fontFamily: 'Raleway')),
              Text(textDesc,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 20,
                      fontWeight: bold,
                      fontFamily: 'Raleway')),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: MediaQuery.of(context).size.width * .9,
            height: 2,
            color: blackColor,
          ),
        ),
      ],
    );
  }
}
