//MODIFICARE LA NEWS PAGE IN MODO CHE SIA SPLITTATA IN 2 TABS LA PRIMA CON LE NEWS LA SECONDA CON LE SCADENZE. FUNZIONE DISPONIBILE SOLO PER OF MEMBER PARALAT TEAM
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/news_property.dart';
import 'package:paralat/screens/HomePage.dart';
import 'package:paralat/screens/dettagli.dart';
import 'package:paralat/screens/impostazioni_page.dart'; // Assicurati di importare la nuova pagina

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  int _index = 1;

  List<Widget>? funzioni = [HomePage(), NewsPage(), ImpostazioniPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('news')
              .orderBy('ora', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var news = snapshot.data!.docs[index];
                // Implementare l'arrivo di news a più persone. Campo to come array. Verifica nel codice se il nome dell'utente è presente nella lista mostra la news.
                if (news['to'] != 'everyone' && news['to'] != Verify().nameUser(0).toLowerCase()) {
                  return SizedBox
                      .shrink(); // Non mostra nulla per questa notizia
                }
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 8, right: 8, bottom: 0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(
                        Icons.newspaper,
                        color: NewsProperty()
                            .setScadColor(news['imp'] ?? Colors.purple),
                      ),
                      title: Text(news['title']),
                      subtitle: Text('${news['body']}\n',
                          overflow: TextOverflow.ellipsis),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsDetailPage(
                              news: news,
                              isNews: true,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: NavFloatBar(
          index: _index,
          funzioni: funzioni,
        ));
  }
}
