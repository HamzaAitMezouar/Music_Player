import 'package:flutter/material.dart';
import 'package:nodejs/src/database/nodejs.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:nodejs/src/pages/musicPlayer.dart';
import 'package:nodejs/src/utils/constant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Music Player',
              style: TextStyle(color: green),
            )),
        body: Center(
          child: FutureBuilder<List>(
            future: Nodejsdata().getApi(),
            initialData: const [],
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Text('NOOODATA');
              } else if (snapshot.hasData) {
                List list = snapshot.data;
                return ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    padding: const EdgeInsets.all(5),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => musicPlayer(
                                      artistName: list[index]['subtitle'],
                                      image: list[index]['images']['coverart'],
                                      title: list[index]['title'],
                                      uri: list[index]['hub']['actions'][1]
                                          ['uri']))));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.network(
                                list[index]['images']['coverart']),
                          ),
                          title: Text(list[index]['title']),
                          subtitle: Text(list[index]['subtitle']),
                        ),
                      );
                    });
              } else
                return const Text('NOOODATA');
            },
          ),
        ));
  }
}
/* TextButton(
          onPressed: (() => Nodejsdata().getApi()), child: Text("test")), Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    /* image: DecorationImage(
                        image: NetworkImage(list[1]['hub']['image'])),*/
                  ),
                ),
                Text(list[0]['hub']['image']),
                Slider(
                  value: currentDuration.inSeconds.toDouble(),
                  onChanged: (value) async {},
                  max: duration.inSeconds.toDouble(),
                  min: 0,
                ),
                Row(
                  children: [
                    Text(currentDuration.toString()),
                    Text(duration.toString()),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                ),
                CircleAvatar(
                  child: IconButton(
                    icon:
                        isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                    onPressed: () async {
                      if (isPlaying) {
                        audioPlayer.pause();
                      } else
                        audioPlayer.play(list[0]['hub']['actions'][1]['uri']);
                    },
                  ),
                )
              ],
            );*/
          
