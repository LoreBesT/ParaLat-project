import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/news_property.dart';

class NewsDetailPage extends StatelessWidget {
  final DocumentSnapshot news;
  final bool isNews;

  const NewsDetailPage({super.key, required this.news, required this.isNews});

  @override
  Widget build(BuildContext context) {
    // Estrai i dati dalla notizia
    final title = news['title'];
    final body = news['body'];
    final color = news['imp'];
    String? formattedDate;
    String? addresser;
    String? adder;
    if (isNews == false) {
      final scadenza = news['scadenza'];
      try {
        adder =
            '\n Evento di: ${news.get('adder')}';
      } catch (e) {
        adder = ''; // Usa la stringa di default se la chiave non esiste
      }
      DateTime date = scadenza.toDate();
      formattedDate =
          '${date.day.toString()}/${date.month.toString()}/${date.year.toString()}';
    } else {
      final address = news['to'];
      if (address.toString() == Auth().getUID()) {
        addresser = 'you';
      } else {
        addresser = address.toString();
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.circle,
                  color: NewsProperty().setScadColor(color),
                ),
                Text(isNews
                    ? 'To $addresser'
                    : ' Scadenza: $formattedDate $adder'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                body,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
