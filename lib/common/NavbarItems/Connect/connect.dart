import 'package:flutter/material.dart';
import 'package:unoquide/common/NavbarItems/Connect/VideoConference/videoConference.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../astudents/Messenger/chats.dart';
import '../../components/commonItems.dart';

// Connect options screen -> root screen for Connect

class Connect extends StatefulWidget {
  const Connect({Key? key}) : super(key: key);

  @override
  State<Connect> createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {
  final imgUrlList = [
    'assets/Images/Connect/videocon.png',
    'assets/Images/Connect/messenger.png',
    'assets/Images/Connect/examination.png'
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageTextClickableContainer(
              width: width * .3,
              height: height * .4,
              imgUrl: 'assets/Images/Connect/videocon.png',
              text: "Video Conferencing",
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const VideoConference()));
              },
            ),
            ImageTextClickableContainer(
              width: width * .3,
              height: height * .4,
              imgUrl: 'assets/Images/Connect/messenger.png',
              text: "Messenger",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Chats()));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ImageTextClickableContainer(
              width: width * .3,
              height: height * .4,
              imgUrl: 'assets/Images/Connect/examination.png',
              text: "Examination",
              onTap: () {
                launchUrl(Uri.parse("https://exam.unoguide.in/"),
                    mode: LaunchMode.externalApplication);
              },
            ),
            SizedBox(
              width: width * .3,
              height: height * .4,
            ),
          ],
        ),
      ],
    );
  }
}
