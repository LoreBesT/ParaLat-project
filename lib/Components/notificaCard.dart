import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
// import 'package:lecosimo/components/share.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:paralat/screens/dettagli.dart';
import 'package:paralat/Components/socialLinks.dart';


class NotificaCard extends StatefulWidget {
  const NotificaCard(
      {super.key,
      required this.title,
      required this.body,
      required this.snapshot,});

  final String title;
  final String body;
  final DocumentSnapshot snapshot;

  @override
  State<NotificaCard> createState() => _NotificaCardState();
}

class _NotificaCardState extends State<NotificaCard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => _navigateToDetailPage(context, widget.snapshot),
        child: SizedBox(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.circularBorder,
            ),
            // elevation: 2,
            clipBehavior: Clip.hardEdge,
            child: _buildCardContent(),
          ),
        ),
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, DocumentSnapshot news) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsDetailPage(news: news)),
    );
  }

  Widget _buildCardContent() {
    return ListTile(
      title: Text(
        widget.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 3
      ),
      subtitle: const Text(
              'Per te',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800),
            ),
      isThreeLine: true,
      leading: Icon(Icons.notifications, color: Colors.yellow[600], size: 32),
    );
  }
}
