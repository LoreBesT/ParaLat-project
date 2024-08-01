// ignore: file_names
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
// import 'package:paralat/screens/assistenza_page.dart';
import 'package:paralat/screens/impostazioni_page.dart';
import 'package:paralat/screens/paralatAI_page.dart';
import 'package:paralat/screens/work_page.dart';
import 'archivio_page.dart';
import 'package:flutter/material.dart';
import 'news_page.dart';
// import 'info_page.dart';
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
    // ignore: prefer_const_constructors
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
                /*radius: 50,*/ child: Text(initialLetters),
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
                testo: 'ParaLat Cards',),
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
                  funzione: WorkPage(), icona: Icons.photo, testo: 'FotoBook'),
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
      )),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        toolbarHeight: 100,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Card(
              elevation: 20,
              child: Column(
                children: [
                  const Text(
                    'Versioni più recenti',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SingleChildScrollView(
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
                                    // elevation: 10,
                                    color: Color.fromRGBO(225, 190, 231, 1),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Icon(Icons.note),
                                        // Text('Versione\npag 345', style: TextStyle(fontSize: 12),),
                                      ],
                                    )),
                              ),
                            ),
                        ]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 250,
            child: Card(
              elevation: 20,
              child: Scrollbar(
                thumbVisibility: true,
                //thickness: 0,
                child: ListView(
                  children: [
                    for (var i in lista)
                      ListTile(
                        title: Text('Avviso $i'),
                        subtitle:
                            const Text('Ciao questo è un avviso di ParaLat'),
                        leading: const Icon(
                          Icons.newspaper_rounded,
                          color: Colors.black,
                        ),
                      )
                  ],
                ),
              ),
            ),
          ),
          //Image.asset('logo_12.png'),
        ],
      ),
    );
  }
}
