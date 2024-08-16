import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/screens/dettagli.dart';
import 'package:paralat/screens/impostazioni_page.dart';
import 'package:paralat/screens/paralatAI_page.dart';
import 'package:paralat/screens/scadenze_page.dart';
import 'package:paralat/screens/sub_page.dart';
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

  // Definisci un ScrollController
  final ScrollController _listViewController = ScrollController();

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
                  funzione: NewsPage(),
                  icona: Icons.newspaper,
                  testo: 'Notizie'),
              if (verifiedUser == ofMember)
                Button(
                    funzione: ScadenzePage(),
                    icona: Icons.warning_amber,
                    testo: 'Scadenze'),
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
        title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.w500)),
        toolbarHeight: 130,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GeminiApiPage(),
                            ),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'ParaLat AI',
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(
                              Icons.generating_tokens,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 160,
                    width: 160,
                    child: Card(
                      elevation: 4,
                      child: InkWell(
                        onTap: () {
                          if (Verify().isPremium(context) == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => ArchivioPage(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => SubPage(),
                              ),
                            );
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Archivio',
                              style: TextStyle(fontSize: 20),
                            ),
                            Icon(
                              Icons.archive,
                              size: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, bottom: 0, left: 12, right: 12),
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
                child: Scrollbar(
                  controller: _listViewController,
                  child: ListView(
                    controller: _listViewController,
                    children: [
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('news') // Usa il nome della tua collezione
                            .orderBy('ora',
                                descending: true) // Assicurati di avere un campo timestamp per ordinare
                            .limit(5) // Limita i risultati agli ultimi 5 documenti
                            .snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return Column(
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
                                  color: Colors.deepPurple,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => NewsDetailPage(
                                        news: doc,
                                        isNews: true,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Space(heigth: 100),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: FloatingNavbar(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        selectedItemColor: Colors.deepPurple,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedBackgroundColor: Color.fromARGB(255, 250, 219, 255),
        elevation: 4,
        onTap: (int val) {
          // returns tab id which is user tapped
        },
        currentIndex: 0,
        items: [
          FloatingNavbarItem(icon: Icons.home, title: 'Home'),
          FloatingNavbarItem(icon: Icons.newspaper, title: 'Notizie'),
          FloatingNavbarItem(icon: Icons.more_horiz, title: 'Altro'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _listViewController.dispose();
    super.dispose();
  }
}
