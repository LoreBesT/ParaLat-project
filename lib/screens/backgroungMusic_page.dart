// import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/Round_buttons.dart';
// import 'package:paralat/Components/music_controller.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool isMusic = false;
  String path = 'assets/audios/ParaLat.mp3';
  Function? musican() {   
    // setState(() {
    //   // isMusic = !isMusic;
    //   Music().togglePlayPause(audioPath: path);
    // });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Background Music'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        toolbarHeight: 100,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 25),
            child: Text(
              'Benvenuto in Background Music.\n La funzionalità è al momento ${isMusic ? 'attivata' : 'disattivata'}',
              style: const TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Card(
            shape: const CircleBorder(),
            elevation: 3,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              child: Stack(
                children: [
                  RoundButtons(
                    icona1: Icons.pause,
                    icona2: Icons.play_arrow,
                    music: isMusic,
                    left: 100,
                    top: 100,
                    funzione: musican(),
                  ),
                  RoundButtons(
                      icona2: Icons.volume_up,
                      music: isMusic,
                      left: 100,
                      top: 10),
                  RoundButtons(
                      icona2: Icons.volume_down,
                      music: isMusic,
                      left: 100,
                      top: 190),
                  RoundButtons(
                      icona2: Icons.skip_next,
                      music: isMusic,
                      left: 190,
                      top: 100),
                  RoundButtons(
                      icona2: Icons.skip_previous,
                      music: isMusic,
                      left: 10,
                      top: 100),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 70,
            width: 310,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              child: const ListTile(
                title: Text(
                  'Hello OMFG',
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                  'Giuseppe Rossi',
                  textAlign: TextAlign.center,
                ),
                leading: Icon(Icons.music_note),
              ),
            ),
          ),
        ],
      ), //Se isMusic è true fai attivata altrimenti disattivata
    );
  }
}
