import 'package:flutter/material.dart';

import '../common/constants/constants.dart';

class DisplaySubWithNameWidget extends StatelessWidget {
  List<dynamic> data;
  int index;
  String id;
  DisplaySubWithNameWidget({
    Key? key,
    required this.data,
    required this.index,
    this.id = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String image;
    String name;
    if (id == '') {
      image = data[index].image.location;
      name = data[index].name;
    } else {
      image = data[index]["image"]['Location'];
      name = data[index]["name"];
    }

    return Container(
      height: 40,
      width: 40,
      margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
          image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5), BlendMode.dstATop),
              fit: BoxFit.cover)),
      child: Center(
        child: Text(name,
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
      ),
    );
  }
}
