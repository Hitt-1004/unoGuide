import 'package:flutter/material.dart';

import '../../components/commonItems.dart';
import '../../constants/constants.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: height * .16,
          ),
          const Text(
            'Statistics',
            style: TextStyle(
                color: blackColor,
                fontSize: 40,
                fontWeight: bold3,
                fontFamily: 'Raleway'),
          ),
          const SizedBox(
            height: 25,
          ),
          Center(
              child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3))
                ]),
            child: Image.asset(
              'assets/Icons/Line chart.png',
              width: width * .65,
              height: height * .55,
            ),
          )),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              StatisticsContainer(
                activity: 'Activites\nCompleted',
                subject1: 'English',
                subject2: 'Mathematics',
                percentage1: 70,
                percentage2: 80,
              ),
              StatisticsContainer(
                activity: 'Videos\nWatched',
                subject1: 'Science',
                subject2: 'Mathematics',
                percentage1: 86,
                percentage2: 80,
              ),
              StatisticsContainer(
                activity: 'Notes Made',
                subject1: 'Science',
                subject2: 'English',
                percentage1: 96,
                percentage2: 88,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
