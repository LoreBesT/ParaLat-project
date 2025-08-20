//Implementare verifica se un utente ha sanzioni con espulsione o meno in homepage. Se vi è una sanzione con espulsione permabannare account e inibire l'accesso all'app
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/rounded_buttons.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/Components/trans.dart';
import 'package:paralat/screens/dettagli.dart';
import 'package:paralat/screens/news_general_page.dart';
import 'package:paralat/screens/notifications_page.dart';
import 'package:paralat/screens/paralatAI_page.dart';
import 'package:paralat/screens/search_page.dart';
import 'package:paralat/screens/work_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  String get title => 'Benvenuto su ParaLat';

  @override
  State<HomePage> createState() => _HomePageState();
}

Stream<bool> areAllReadStream(String collectionName) {
  return FirebaseFirestore.instance
      .collection(collectionName)
      .where('to', isNotEqualTo: 'everyone')
      .snapshots()
      .map((querySnapshot) {
    // Se non ci sono documenti, consideriamo "tutto letto"
    if (querySnapshot.docs.isEmpty) return true;

    // Se almeno uno è false → ritorna false
    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      if (data['isRead'] == false) {
        return false;
      }
    }

    return true;
  });
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  // List<Widget> funzioni = [HomePage(), NewsPage(), ImpostazioniPage()];
  bool isFavorite = false;
  List<int> lista = [1, 2, 3, 4];
  int index = 1;
  String nomeUtente = Verify().nameUser(4);
  String ofMember = Verify().typeUser(0);

  // Definisci un ScrollController
  final ScrollController _listViewController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? funzioni = Verify().funzioniBottAppBar(context);
    Verify().verifyUser(context).toString();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              )),
          // leading: IconButton(icon: Icon(Icons.notifications), onPressed: (){},),
          actions: [
            IconButton(
              icon: StreamBuilder(
                  stream: areAllReadStream("news"),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Icon(
                        Icons.notifications_none,
                        size: 30,
                      );
                    }
                    bool tutteLette = snapshot.data!;
                    return Icon(
                      tutteLette
                          ? Icons.notifications_none
                          : Icons.notifications_active,
                      size: 30,
                      color: tutteLette ? null : Colors.deepPurple[700],
                    );
                  }),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationsPage(),
                  ),
                );
              },
            ),
          ],
          toolbarHeight: 130,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedButtons(
                      testo: 'ParaLat AI',
                      icon: Icons.generating_tokens,
                      function: GeminiApiPage(),
                      iconColor: Colors.deepPurple,
                    ),
                    RoundedButtons(
                      testo: 'Archivio',
                      icon: Icons.archive,
                      function: WorkPage(),
                      iconColor: Colors.deepPurple,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 0, left: 12, right: 12),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text('Ultime Notizie'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NewsGeneralPage(),
                            ),
                          );
                        },
                        child: const Text('Vedi tutte'),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SizedBox(
                    height: 260,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 2,
                      child: Scrollbar(
                        controller: _listViewController,
                        child: ListView(
                          controller: _listViewController,
                          children: [
                            StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(
                                      'news') // Usa il nome della tua collezione
                                  .orderBy('ora',
                                      descending:
                                          true) // Assicurati di avere un campo timestamp per ordinare
                                  .limit(
                                      8) // Limita i risultati agli ultimi 5 documenti dove 'to' == 'news'
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                }
          
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: snapshot.data!.docs.map((doc) {
                                    var title = doc['title'];
                                    var body = doc['body'];
                                    if (doc['to'] != 'news') {
                                      return const SizedBox
                                          .shrink(); // Non mostra nulla per questa notizia
                                    }
                                    return ListTile(
                                      title: Text(title),
                                      subtitle: Text(
                                        body,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      leading: const Icon(
                                        Icons.newspaper,
                                        color: Colors.deepPurple,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => NewsDetailPage(
                                              news: doc,
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
                ),
                const Space(heigth: 100),
              ],
            ),
          ),
        ),
        extendBody: true,
        // floatingActionButton: FloatingActionButton(onPressed: (){}, child: Icon(Icons.translate),),
        bottomNavigationBar: NavFloatBar(
          index: _index,
          funzioni: funzioni,
        ));
  }

  @override
  void dispose() {
    _listViewController.dispose();
    super.dispose();
  }
}
