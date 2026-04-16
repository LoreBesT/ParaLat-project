import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/screens/dettagli_notice.dart';

class NotificaCard extends StatefulWidget {
  const NotificaCard({
    super.key,
    required this.title,
    required this.body,
    required this.isRead,
    required this.snapshot,
  });

  final String title;
  final String body;
  final DocumentSnapshot snapshot;
  final bool isRead;

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
      padding: const EdgeInsets.only(bottom: 8),
      child: _buildCardContent(),
    );
  }

  void _navigateToDetailPage(BuildContext context, DocumentSnapshot news) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoticeDetailPage(news: news)),
    );
  }

  Widget _buildCardContent() {
    return InkWell(
      borderRadius: AppRadius.circularBorder,
      onTap: () => _navigateToDetailPage(context, widget.snapshot),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 10, right: 10),
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.circularBorder,
        ),
        tileColor: AppColors.cardTile,
        title: Text(widget.title,
            style: TextStyle(color: AppColors.text),
            overflow: TextOverflow.ellipsis,
            maxLines: 1),
        subtitle: Text(
          widget.body,
          style: TextStyle(color: AppColors.gradientStart, fontSize: 12),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: widget.isRead ? SizedBox.shrink() : Icon(Icons.circle, color: AppColors.text, size: 15,),
        isThreeLine: false,
        // leading: Icon(Icons.notifications, color: Colors.yellow[600], size: 32),
      ),
    );
  }
}
