import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class Recorded extends StatefulWidget {
  const Recorded({Key? key}) : super(key: key);

  @override
  State<Recorded> createState() => _RecordedState();
}

class _RecordedState extends State<Recorded> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "No Data to display",
        style: TextStyle(fontSize: 20, fontWeight: bold, fontFamily: 'Raleway'),
      ),
    );
  }
}
