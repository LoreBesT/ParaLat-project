import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paralat/Components/notificaCard.dart';

class ImpostazioniPage2 extends StatefulWidget {
  const ImpostazioniPage2({super.key});

  @override
  State<ImpostazioniPage2> createState() => _ImpostazioniPage2State();
}

class _ImpostazioniPage2State extends State<ImpostazioniPage2> {
  String? uid;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      uid = Auth().metaDatas(context, 3);

      if (uid != null) {
        await Auth().creaNotifiche(uid!);
        setState(() {}); // aggiorna UI dopo creazione notifiche
      }
    });
  }

  bool isToYou = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(children: [
            ListTile(
              contentPadding: EdgeInsets.all(8),
              shape: RoundedRectangleBorder(
                borderRadius: AppRadius.circularBorder,
              ),
              tileColor: AppColors.cardTile,
              leading: CircleAvatar(
                  child: Text(Verify().nameUser(4),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20)),
                  radius: 30,
                  backgroundColor: AppColors.gradientStart),
              title: Text(
                Verify().nameUser(3),
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text),
              ),
              subtitle: Text(
                Auth().getEmail() ?? 'No email',
                style: TextStyle(fontSize: 12, color: AppColors.gradientStart),
              ),
            ),
            SizedBox(height: 20),

            DesignSettings().sectionTile(
                title: "Notifiche Personali",
                icon: Icons.notifications_outlined,
                badgeCount: 4),

            StreamBuilder(
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

                // 🔥 FILTRO PER UID
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: filteredDocs.length,
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
          ]),
        ),
      ),
    );
  }
}