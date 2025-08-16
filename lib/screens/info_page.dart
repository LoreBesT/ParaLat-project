import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:paralat/Components/socialLinks.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    String riconoscimenti =
        'ParaLat è un progetto ideato e realizzato da LoreDB. Tutti i diritti sono riservati.\n\nUn rigranziamento in particolare a chiunque voglia collaborare con feedback e segnalazioni.\n\n';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  riconoscimenti,
                  style: const TextStyle(fontSize: 16),
                  // textAlign: TextAlign.justify,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Image.asset(r'assets\images\ParaLat.png'),
                ),
                ],
              ),
            ),
          ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ClipOval(
                child: IconButton(
                  onPressed: () {
                    openIg('paralatstudy');
                  },
                  icon: const Icon(FontAwesomeIcons.instagram),
                ),
              ),
              ClipOval(
                child: IconButton(
                  onPressed: () {
                    openTikTok('paralatstudy');
                  },
                  icon: const Icon(Icons.tiktok),
                ),
              ),
              ClipOval(
                child: IconButton(
                  onPressed: () {
                    openYt('UCtBXof55sNXZrUGkbN4VQqA');
                  },
                  icon: const Icon(FontAwesomeIcons.youtube),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
