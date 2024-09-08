//Implementare verifica se un utente ha sanzioni con espulsione o meno in homepage. Se vi è una sanzione con espulsione permabannare account e inibire l'accesso all'app
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/screens/dettagli.dart';
import 'package:paralat/screens/paralatAI_page.dart';
import 'package:paralat/screens/search_page.dart';
import 'package:paralat/screens/sub_page.dart';
import 'archivio_page.dart';
import 'news_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  String get title => 'Benvenuto su ParaLat';

  @override
  State<HomePage> createState() => _HomePageState();
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
  Widget build(BuildContext context) {
    List<Widget>? funzioni = Verify().funzioniBottAppBar(context);
    Verify().verifyUser(context).toString();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )),
          toolbarHeight: 130,
          centerTitle: true,
          automaticallyImplyLeading: false,
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
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) => SearchPage(),
                              ),
                            );
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
                padding: const EdgeInsets.only(
                    top: 0, bottom: 0, left: 12, right: 12),
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
                              .collection(
                                  'news') // Usa il nome della tua collezione
                              .orderBy('ora',
                                  descending:
                                      true) // Assicurati di avere un campo timestamp per ordinare
                              .limit(
                                  5) // Limita i risultati agli ultimi 5 documenti
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }

                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: snapshot.data!.docs.map((doc) {
                                var title = doc['title'];
                                var body = doc['body'];
                                if (doc['to'] != 'everyone' &&
                                    doc['to'] != Auth().getUID()) {
                                  return SizedBox
                                      .shrink(); // Non mostra nulla per questa notizia
                                }
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
