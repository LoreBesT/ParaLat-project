import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/feedNewsCard.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
  });

  @override
  State<NotificationsPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
  }

  bool isToYou = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ultime notifiche'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('news')
            .orderBy('ora', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          //   return const Text('Nessuna notifica');
          // }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var news = snapshot.data!.docs[index];
              if (news['to'] != 'everyone' && news['to'] != Auth().getUID()) {
                return const SizedBox.shrink();
              }
              if (news['to'] == Auth().getUID()) {
                isToYou = true;
              } else {
                isToYou = false;
              }
              return isToYou
                  ? FeedNewsCard(
                      title: news['title'],
                      autore: news['autore'],
                      body: news['body'],
                      snapshot: news,
                      image: isToYou ? 'null' : news['image'],
                      toYou: news['to'] == Auth().getUID() ? true : false,
                    )
                  : const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }
}
