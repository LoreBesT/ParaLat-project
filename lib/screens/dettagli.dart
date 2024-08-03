import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsDetailPage extends StatelessWidget {
  final DocumentSnapshot news;

  NewsDetailPage({required this.news});

  @override
  Widget build(BuildContext context) {
    // Estrai i dati dalla notizia
    final title = news['title'];
    final body = news['body'];

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              body,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
