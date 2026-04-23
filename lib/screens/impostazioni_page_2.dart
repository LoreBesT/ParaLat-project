import 'package:flutter/material.dart';
import 'package:paralat/Components/donation_button.dart';
import 'package:paralat/Components/drawer_buttons/drawerButton.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/drawer_buttons/drawerButtonfunction.dart';
import 'package:paralat/Components/drawer_buttons/drawerSwitchButton.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/notificaCard.dart';
import 'package:paralat/screens/assistenza_page.dart';
import 'package:paralat/screens/auth_page_2.dart';
import 'package:paralat/screens/infoapp_page.dart';

class ImpostazioniPage2 extends StatefulWidget {
  const ImpostazioniPage2({super.key});

  @override
  State<ImpostazioniPage2> createState() => _ImpostazioniPage2State();
}

class _ImpostazioniPage2State extends State<ImpostazioniPage2> {
  String? uid;
  final int _index = 3;
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
    List<Widget>? funzioni = Verify().funzioniBottAppBar(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Impostazioni'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            ListTile(
              contentPadding: const EdgeInsets.all(8),
              shape: const RoundedRectangleBorder(
                borderRadius: AppRadius.circularBorder,
              ),
              tileColor: AppColors.cardTile,
              leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.gradientStart,
                  child: Text(Verify().nameUser(4),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20))),
              title: Text(
                Verify().nameUser(3),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text),
              ),
              subtitle: Text(
                Auth().getEmail() ?? 'No email',
                style: const TextStyle(
                    fontSize: 12, color: AppColors.gradientStart),
              ),
            ),
            const SizedBox(height: 10),
            // SupportCard(),
            Divider(),
            StreamBuilder<int>(
              stream: Auth().getUnreadCountStream(uid.toString()),
              builder: (context, snapshot) {
                final count = snapshot.data ?? 0;

                if (snapshot.hasError) {
                  return DesignSettings().sectionTile(
                    context: context,
                    title: "Notifiche Personali",
                    icon: Icons.notifications_outlined,
                    badgeCount: 0,
                  );
                }

                return DesignSettings().sectionTile(
                  context: context,
                  title: "Notifiche Personali",
                  icon: Icons.notifications_outlined,
                  badgeCount: count,
                );
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('notifiche_personali')
                  .orderBy('ora', descending: true)
                  .limit(3)
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
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredDocs.length,
                  itemBuilder: (context, index) {
                    var notifica = filteredDocs[index];

                    return NotificaCard(
                      title: notifica['title'],
                      body: notifica['body'],
                      snapshot: notifica,
                      isRead: notifica['letto'],
                    );
                  },
                );
              },
            ),
            const Divider(),
            SupportCard(),
            Divider(),
            DesignSettings().sectionTile(
                title: "Preferenze",
                icon: Icons.settings_outlined,
                context: context),
            const ButtonNoAnimatedTr(
                testo: "Modalità scura", icona: Icons.wb_sunny_outlined),
            const ButtonNoAnimatedTr(
                testo: "Notifiche Push",
                icona: Icons.notifications_none_rounded),
            ButtonFunction(
              icona: Icons.key,
              funzione: (context) async {
                await Auth().reimpostaPassword(context, false);
              },
              testo: "Reimposta Password",
              subtitle: "Modifica la password del tuo account",
              snackmessage:
                  "Email inviata, controlla la tua casella di posta elettronica.",
            ),
            const Divider(),
            DesignSettings().sectionTile(
                title: "Altro",
                icon: Icons.space_dashboard_outlined,
                context: context),
            const Button(
                icona: Icons.help_outline,
                funzione: AssistenzaPage(),
                testo: "Centro Assistenza"),
            const Button(
                icona: Icons.info_outline_rounded,
                funzione: InfoappPage(),
                testo: "Informazioni"),
            ButtonFunction(
              icona: Icons.exit_to_app_rounded,
              funzione: (context) async {
                await Auth().signOut(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const AuthPage2(),
                //   ),
                // );
                //valutare di mettere un spostamento sulla pagina di auth
              },
              testo: "Log out",
              subtitle: "Disconnetti il tuo account",
              snackmessage: "Log out effettuato.",
              isWarming: true,
            ),
            ButtonFunction(
              icona: Icons.cancel_outlined,
              funzione: (context) async {
                // await Auth().deleteAccount(context);
              },
              testo: "Elimina account",
              subtitle: "Rimuovi permanentemente il tuo account",
              snackmessage: "Funzione momentaneamente non disponibile",
              isWarming: true,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Powered by ParaLat Group\n© 2026 All rights reserved',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: NavFloatBar(
        index: _index,
        funzioni: funzioni,
      ),
    );
  }
}
