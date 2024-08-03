import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/screens/dettagli.dart';
import 'package:paralat/screens/impostazioni_page.dart';
import 'package:paralat/screens/paralatAI_page.dart';
import 'package:paralat/screens/work_page.dart';
import 'archivio_page.dart';
import 'news_page.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  String get title => 'Benvenuto su ParaLat';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isFavorite = false;
  List<int> lista = [1, 2, 3, 4];
  int index = 1;
  String nomeUtente = Verify().nameUser(4);
  String ofMember = 'Official Member ParaLat Team';

  @override
  Widget build(BuildContext context) {
    String verifiedUser = Verify().verifyUser(context);
    String? initialLetters = Auth().getInitials(nomeUtente);

    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Column(
            children: [
              Chip(
                label: Text(nomeUtente),
                avatar: CircleAvatar(
                  minRadius: 30,
                  backgroundColor: Colors.green,
                  child: Text(initialLetters),
                ),
                elevation: 30,
              ),
              Button(
                  funzione: GeminiApiPage(),
                  icona: Icons.generating_tokens_rounded,
                  testo: 'ParaLat AI'),
              Button(
                funzione: WorkPage(),
                icona: Icons.badge,
                testo: 'ParaLat Cards',
              ),
              Button(
                  funzione: NewsPage(),
                  icona: Icons.newspaper,
                  testo: 'Notizie Principali'),
              if (verifiedUser == ofMember)
                Button(
                    funzione: WorkPage(),
                    icona: Icons.warning_amber,
                    testo: 'Scadenze'),
              Button(
                funzione: ArchivioPage(),
                icona: Icons.archive,
                testo: 'Archivio Versioni',
                isPremium: Verify().isPremium(context),
              ),
              if (verifiedUser == ofMember)
                Button(
                    funzione: WorkPage(),
                    icona: Icons.photo,
                    testo: 'FotoBook'),
              Button(
                funzione: ImpostazioniPage(),
                icona: Icons.settings,
                testo: 'Impostazioni',
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: const ButtonStyle(
                    animationDuration: Duration(seconds: 1),
                  ),
                  onPressed: () {
                    Auth().signOut(context);
                  },
                  child: Animate(
                    effects: const [ScaleEffect()],
                    child: const Row(
                      children: [
                        Icon(Icons.exit_to_app),
                        SizedBox(width: 8),
                        Text('Esci'),
                      ],
                    ),
                  ),
                ),
              ),
              const Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Versione 1.0.0\nMade by Lorenzo Della Bona',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ))),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        toolbarHeight: 100,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(top: 2, bottom: 2, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text('Versioni più recenti'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkPage(),
                      ),
                    );
                  },
                  child: Text('Vedi tutte'),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 130,
            child: Card(
              elevation: 4,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (var i = 0; i < 6; i++)
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: SizedBox(
                          height: 100,
                          width: 100,
                          child: Card(
                            color: Color.fromRGBO(225, 190, 231, 1),
                            child: Column(
                              children: [
                                SizedBox(height: 30),
                                Icon(Icons.note),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 2, bottom: 2, left: 16, right: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text('Ultime Notizie'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewsPage(),
                      ),
                    );
                  },
                  child: Text('Vedi tutte'),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 250,
            child: Card(
              elevation: 4,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('news') // Usa il nome della tua collezione
                    .orderBy('ora',
                        descending:
                            true) // Assicurati di avere un campo timestamp per ordinare
                    .limit(5) // Limita i risultati agli ultimi 4 documenti
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Scrollbar(
                    thumbVisibility: true,
                    child: ListView(
                      children: snapshot.data!.docs.map((doc) {
                        var title = doc['title'];
                        var body = doc['body'];

                        return ListTile(
                          title: Text(title),
                          subtitle: Text(
                            body,
                            overflow: TextOverflow.ellipsis,
                          ),
                          leading: Icon(
                            Icons.newspaper,
                            color: Colors.black,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailPage(news: doc),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
