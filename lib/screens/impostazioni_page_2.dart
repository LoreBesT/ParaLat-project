import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paralat/Components/feedNewsCard.dart';

class ImpostazioniPage2 extends StatefulWidget {
  const ImpostazioniPage2({super.key});

  @override
  State<ImpostazioniPage2> createState() => _ImpostazioniPage2State();
}

class _ImpostazioniPage2State extends State<ImpostazioniPage2> {
  @override
  void initState() {
    super.initState();
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
            SizedBox(
              height: 20,
            ),
            DesignSettings().sectionTile(
                title: "Notifiche Personali",
                icon: Icons.notifications_outlined,
                badgeCount: 4),
            StreamBuilder(
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var news = snapshot.data!.docs[index];
                    if (news['to'] != 'news' &&
                        news['to'] != Auth().getUID() &&
                        news['to'] != 'avviso') {
                      return const SizedBox.shrink();
                    }
                    if (news['to'] == Auth().getUID() ||
                        news['to'] == 'avviso') {
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
                            toYou: news['to'] == Auth().getUID() ||
                                    news['to'] == 'avviso'
                                ? true
                                : false,
                          )
                        : const SizedBox.shrink();
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
