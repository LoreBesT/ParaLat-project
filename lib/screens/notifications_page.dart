import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/notificaCard.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({
    super.key,
  });

  @override
  State<NotificationsPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationsPage> {
  late String? uid;
  bool isToYou = false;

  @override
  void initState() {
    super.initState();
    uid = Auth().metaDatas(context, 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ultime notifiche'),
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('notifiche_personali')
              .orderBy('ora', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
        
            if (!snapshot.hasData) {
                    return const Text('Errore caricamento');
            }
        
            final filteredDocs = snapshot.data!.docs.where((doc) {
                    if (uid == null) return false;
        
                    final docId = doc.id;
        
                    // prende parte dopo "_"
                    if (!docId.contains('_')) return false;
        
                    final docUid = docId.split('_').last;
        
                    return docUid == uid;
                  }).toList();
        
                  if (filteredDocs.isEmpty) {
                    return const Text('Nessuna notifica');
            }
        
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var notifica = filteredDocs[index];
                return NotificaCard(
                        title: notifica['title'],
                        body: notifica['body'],
                        snapshot: notifica,
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
