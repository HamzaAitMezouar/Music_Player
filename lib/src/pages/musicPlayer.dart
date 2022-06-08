// ignore_for_file: sort_child_properties_last

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:nodejs/src/utils/constant.dart';

class musicPlayer extends StatefulWidget {
  String uri;
  String image;
  String title;
  String artistName;
  musicPlayer(
      {Key? key,
      required this.artistName,
      required this.image,
      required this.title,
      required this.uri})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<musicPlayer> createState() => musicPlayerState(
      uri: uri, artistName: artistName, image: image, title: title);
}

class musicPlayerState extends State<musicPlayer> {
  String uri;
  String image;
  String title;
  String artistName;
  musicPlayerState(
      {required this.artistName,
      required this.image,
      required this.title,
      required this.uri});
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration currentDuration = Duration.zero;
  @override
  void initState() {
    super.initState();
    // Listen To PLAY PAUSE PLAY ,STop ...
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.PLAYING;
      });
    });
    //Audio DURATIOn
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    // Audio Position Change
    audioPlayer.onAudioPositionChanged.listen((newPosition) {
      setState(() {
        currentDuration = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Card(
                shadowColor: green,
                color: backGroundColor,
                elevation: 8,
                child: Container(
                  height: 200,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: NetworkImage(image), fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(artistName),
            Slider(
              inactiveColor: green.withOpacity(0.5),
              activeColor: green,
              thumbColor: green,
              value: currentDuration.inSeconds.toDouble(),
              onChanged: (value) async {},
              max: duration.inSeconds.toDouble(),
              min: 0,
            ),
            Row(
              children: [
                Text(_printDuration(currentDuration)),
                Text(_printDuration(duration)),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            CircleAvatar(
              backgroundColor: green,
              child: IconButton(
                icon: isPlaying
                    ? const Icon(Icons.pause)
                    : const Icon(
                        Icons.play_arrow,
                      ),
                onPressed: () async {
                  if (isPlaying) {
                    audioPlayer.pause();
                  } else
                    audioPlayer.play(uri);
                },
              ),
            ),
            isPlaying
                ? Container(
                    height: size.height * 0.1,
                    child: Lottie.network(
                        'https://assets6.lottiefiles.com/packages/lf20_mc0ry5ol.json'),
                  )
                : Container()
          ],
        ));
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
