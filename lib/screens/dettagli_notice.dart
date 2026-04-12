import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:paralat/Components/appUiStandards.dart';


class NoticeDetailPage extends StatelessWidget {
  final DocumentSnapshot news;
  const NoticeDetailPage({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    // Estrai i dati dalla notizia
    final title = news['title'];
    final body = news['body'];
    final ora = news['ora'];
    // Auth().markAsRead(context, news.id);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: const Text('Avviso'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(title),
                const Divider(),
                _buildGeneralInfo(ora),
                const Divider(),
                _buildBody(body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildTitle(String title) {
  return Text(
    title,
    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
  );
}

Widget _buildGeneralInfo(Timestamp ora) {
  final data = ora.toDate();

  const mesi = [
    'gennaio',
    'febbraio',
    'marzo',
    'aprile',
    'maggio',
    'giugno',
    'luglio',
    'agosto',
    'settembre',
    'ottobre',
    'novembre',
    'dicembre'
  ];

  final formattedDate = '${data.day} ${mesi[data.month - 1]} ${data.year}';

  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(1.0),
            child: Text(formattedDate,
                    style: TextStyle(
                      color: AppColors.infoBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ))
          ),
        ],
      ),
    ],
  );
}

Widget _buildBody(String body) {
  return Text(body, style: const TextStyle(fontSize: 18),);
}