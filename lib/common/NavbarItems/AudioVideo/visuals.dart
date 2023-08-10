import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Visuals extends StatefulWidget {
  final String subjectName;

  const Visuals({Key? key, required this.subjectName}) : super(key: key);

  @override
  State<Visuals> createState() => _VisualsState();
}

class _VisualsState extends State<Visuals> {
  final YoutubePlayerController _controller =
      YoutubePlayerController.fromVideoId(
    videoId: '0LXACUqRUWo',
    params: const YoutubePlayerParams(
      showControls: true,
      showFullscreenButton: true,
      mute: false,
    ),
  );
  final videoList = [
    "0LXACUqRUWo",
    'GxAf-U0TWFQ',
    'bjerlwYFrmc',
    '34Dr5HYF6VY',
    'fWMgsL1f908',
    'Rz0lOGtCkLE',
    'mJlxyNjx7Uc',
    '72-wpfNrLEo',
    'OOvQ6ilU50c',
    'wB9kS7It6jA',
    'S4cllKE5h-o',
    'gJI3mQIf_fI',
    'VwrMNkWnMVg',
    'WwTdAYWOYPs',
    '3lPspTetBws',
    '_CP81CC2aKA',
  ];
  @override
  void initState() {
    // TODO: implement initState
    showToast();
    super.initState();
  }

  showToast() {
    Fluttertoast.showToast(
        msg: "Scroll Down to See More Videos",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Column(
      children: <Widget>[
        const SizedBox(
          height: 5,
        ),
        Center(
          child: SizedBox(
            height: height * .5,
            width: width * .6,
            child: YoutubePlayer(controller: _controller),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: .9 * width,
          height: .47 * height,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(videoList.length, (index) {
              return ImageButton(
                  videoId: videoList[index],
                  index: index,
                  onTap: () {
                    setState(() {
                      _controller.loadVideoById(videoId: videoList[index]);
                      _controller.playVideo();
                    });
                  });
            }),
          ),
        ),
      ],
    );
  }
}

// class YoutubeFrame extends StatelessWidget {
//   const YoutubeFrame(
//       {Key? key,
//       required this.videoId,
//       required this.height,
//       required this.width})
//       : super(key: key);
//   final String videoId;
//   final double height;
//   final double width;
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height,
//       width: width,
//       child: YoutubePlayer(
//         controller: YoutubePlayerController.fromVideoId(
//           videoId: videoId,
//           params: const YoutubePlayerParams(
//             mute: false,
//             loop: true,
//             showControls: true,
//             showFullscreenButton: true,
//           ),
//         ),
//       ),
//     );
//   }
// }
class ImageButton extends StatelessWidget {
  const ImageButton(
      {Key? key,
      required this.videoId,
      required this.index,
      required this.onTap})
      : super(key: key);
  final Function onTap;
  final String videoId;
  final int index;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Center(
        child: InkWell(
            onTap: () {
              onTap();
            },
            child: Column(
              children: [
                Text(
                  "Chapter ${index + 1}",
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Image.network(
                  "https://img.youtube.com/vi/$videoId/sddefault.jpg",
                  height: height * 0.4,
                  width: width * 0.25,
                ),
              ],
            )));
  }
}
