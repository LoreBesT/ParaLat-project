import 'package:flutter/material.dart';

class ThemePage extends StatelessWidget {
  ThemePage({super.key});
  List<IconData> sunOrMoon = [
    Icons.sunny,
    Icons.nightlight,
    Icons.sunny,
    Icons.sunny,
    Icons.sunny
  ];
  List<Color> colore = [
    Colors.deepPurple,
    Colors.black,
    Colors.yellow.shade800,
    Colors.lightBlue,
    Colors.pink
  ];
  List<String> nomeColore = [
    'ParaLat classic',
    'Default black',
    'Gold Theme',
    'Sea Theme',
    'Pink Theme'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambia Tema'),
      ),
      body: GridView.builder(
          itemCount: 5,
          padding: EdgeInsets.all(16),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    sunOrMoon[index],
                    color: colore[index],
                    size: 60,
                  ),
                  SizedBox(height: 10,),
                  Text('${nomeColore[index]}'),
                ],
              ),
            );
          }),
    );
  }
}
