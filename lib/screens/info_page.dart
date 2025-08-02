import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    String riconoscimenti =
        'ParaLat è un progetto ideato e realizzato da Lorenzo Della Bona.\nUn rigranziamento a chiunque voglia collaborare con feedback e segnalazioni.\n\nCredits:\n● Lorenzo Della Bona: Android Developer, ideatore e realizzatore di ParaLat \n';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Credits'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                riconoscimenti,
                style: const TextStyle(fontSize: 16),
                // textAlign: TextAlign.justify,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Image.asset(r'assets\images\ParaLat.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
