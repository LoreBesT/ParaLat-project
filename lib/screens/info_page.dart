import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    String riconoscimenti =
        'ParaLat App è un progetto ideato e realizzato da Lorenzo Della Bona. Un rigranziamento a tutti coloro che hanno collaborato e che vorrano contribuire con feedback e segnalazioni.\n\nCredits:\n● Lorenzo Della Bona: Android Developer\n● Francesca Bariletto - 25/05/2023\n● Letizia Marzo - 25/05/2023\n● Nicole Pastore - 25/05/2023 \n● Annamaria Alba - 29/09/2023\n● Luca Martella - 29/09/2023\n● Mario Accogli - 28/02/2024\n● Jacopo Leo - 14/03/2024\n';
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
                textAlign: TextAlign.justify,
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
