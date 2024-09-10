import 'package:flutter/material.dart';
import 'package:paralat/Components/feedCard.dart';

class Feed extends StatefulWidget {
  const Feed({super.key});

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox(
        width: double.maxFinite,
        child: Column(
          children: [
            Feedcard(text: 'Carpe Diem', type: 'Letteratura', autore: 'Orazio'),
            Feedcard(text: 'Aurea Mediocritas', type: 'Letteratura', autore: 'Orazio'),
            Feedcard(text: 'Carpe Diem', type: 'Letteratura', autore: 'Orazio'),
            Feedcard(text: 'Aurea Mediocritas', type: 'Letteratura', autore: 'Orazio'),
            Feedcard(text: 'Carpe Diem', type: 'Letteratura', autore: 'Orazio'),
            Feedcard(text: 'Aurea Mediocritas', type: 'Letteratura', autore: 'Orazio'),
            
          ],
        ),
      ),
    );
  }
}