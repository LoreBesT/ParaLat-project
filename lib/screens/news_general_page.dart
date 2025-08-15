import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/feedNewsCard.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/screens/HomePage.dart';
import 'package:paralat/screens/impostazioni_page.dart'; // Assicurati di importare la nuova pagina

class NewsGeneralPage extends StatefulWidget {
  const NewsGeneralPage({super.key});

  @override
  State<NewsGeneralPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsGeneralPage> {
  final int _index = 1;
  bool isToYou = false;

  int _limit = 15; // inizialmente 10 news
  final int _limitIncrement = 15; // ogni volta ne aggiungiamo 10
  final ScrollController _scrollController = ScrollController();

  List<Widget> funzioni = [
    const HomePage(),
    const NewsGeneralPage(),
    const ImpostazioniPage()
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _limit += _limitIncrement;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notizie ed Eventi'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('news')
            .orderBy('ora', descending: true)
            .limit(_limit)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: snapshot.data!.docs.length + 1,
            itemBuilder: (context, index) {
              if (index == snapshot.data!.docs.length) {
                // questo è il loader in fondo
                if (snapshot.data!.docs.length < _limit) {
                  return const SizedBox.shrink(); // niente da caricare
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              }
              var news = snapshot.data!.docs[index];
              if (news['to'] != 'news' &&
                  news['to'] != Auth().getUID() &&
                  news['to'] != 'avviso') {
                return const SizedBox.shrink();
              }
              if (news['to'] == Auth().getUID() || news['to'] == 'avviso') {
                isToYou = true;
              } else {
                isToYou = false;
              }
              return isToYou
                  ? const SizedBox.shrink()
                  : FeedNewsCard(
                      title: news['title'],
                      autore: news['autore'],
                      body: news['body'],
                      snapshot: news,
                      image: isToYou ? 'null' : news['image'],
                      toYou: news['to'] == Auth().getUID(),
                    );
            },
          );
        },
      ),
      bottomNavigationBar: NavFloatBar(
        index: _index,
        funzioni: funzioni,
      ),
    );
  }
}
