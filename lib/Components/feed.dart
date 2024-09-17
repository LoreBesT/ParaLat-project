import 'package:flutter/material.dart';
import 'package:paralat/Components/feedCard.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<List<String>> documenti = [
    ['Carpe Diem', 'Orazio'],
    ['Aurea Mediocritas', 'Orazio'],
    ['Eneide 1-2', 'Virgilio'],
  ];
  @override
  Widget build(BuildContext context) {
    documenti.shuffle();
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Feedcard(text: documenti[0][0], type: 'Letteratura', autore: documenti[0][1]),
            Feedcard(text: documenti[1][0], type: 'Letteratura', autore: documenti[1][1]),
            Feedcard(text: documenti[2][0], type: 'Letteratura', autore: documenti[2][1]),
          ],
        ),
      ),
    );
  }
}
