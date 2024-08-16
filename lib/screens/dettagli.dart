import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paralat/Components/news_property.dart';

class NewsDetailPage extends StatelessWidget {
  final DocumentSnapshot news;
  final bool isNews;

  NewsDetailPage({required this.news, required this.isNews});

  @override
  Widget build(BuildContext context) {
    // Estrai i dati dalla notizia
    final title = news['title'];
    final body = news['body'];
    final color = news['imp'];
    String? formattedDate;
    if (isNews == false) {
      final scadenza = news['scadenza'];
      DateTime date = scadenza.toDate();
      formattedDate =
          '${date.day.toString()}/${date.month.toString()}/${date.year.toString()}';
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
            if (isNews == false)
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: NewsProperty().setScadColor(color),
                  ),
                  Text(' Scadenza: $formattedDate'),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                body,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
