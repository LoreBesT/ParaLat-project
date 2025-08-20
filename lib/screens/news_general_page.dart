import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/feedNewsCard.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/screens/HomePage.dart';
import 'package:paralat/screens/impostazioni_page.dart';

class NewsGeneralPage extends StatefulWidget {
  const NewsGeneralPage({super.key});

  @override
  State<NewsGeneralPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsGeneralPage> {
  final int _index = 1;
  bool isToYou = false;

  int _limit = 15;
  final int _limitIncrement = 15;
  final ScrollController _scrollController = ScrollController();

  List<Widget> funzioni = [
    const HomePage(),
    const NewsGeneralPage(),
    const ImpostazioniPage()
  ];

  // Lista di poche NativeAd da riciclare
  final List<NativeAd> _nativeAds = [];
  final List<bool> _adsLoaded = [];
  final String nativeAdUnitId = "ca-app-pub-3940256099942544/2247696110"; // TEST ID

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _initNativeAds();
  }

  void _initNativeAds() {
    // Creiamo 2 NativeAd da riciclare
    for (int i = 0; i < 2; i++) {
      final ad = NativeAd(
        adUnitId: nativeAdUnitId,
        request: const AdRequest(),
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            setState(() {
              _adsLoaded[i] = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            debugPrint("Errore caricamento NativeAd: $error");
          },
        ),
        nativeTemplateStyle: NativeTemplateStyle(
          templateType: TemplateType.medium,
        ),
      );
      _nativeAds.add(ad);
      _adsLoaded.add(false);
      ad.load();
    }
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
    for (final ad in _nativeAds) {
      ad.dispose();
    }
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

          // Calcolo totale item = news + ads
          int totalNews = snapshot.data!.docs.length;
          int totalAds = totalNews ~/ 3; // 1 ad ogni 3 news
          int totalItems = totalNews + totalAds;

          return ListView.builder(
            controller: _scrollController,
            itemCount: totalItems,
            itemBuilder: (context, index) {
              // Loader in fondo
              if (index == totalItems) {
                if (totalNews < _limit) {
                  return const SizedBox.shrink();
                } else {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              }

              // Calcola quante ads ci sono prima di questo indice
              int numberOfAdsBefore = index ~/ 4;
              int newsIndex = index - numberOfAdsBefore;

              // Inserisci NativeAd ogni 3 news
              if ((index + 1) % 4 == 0) {
                int adIndex = numberOfAdsBefore % _nativeAds.length;
                if (_adsLoaded[adIndex]) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    height: 120,
                    child: AdWidget(ad: _nativeAds[adIndex]),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }

              // Mostra news normale
              var news = snapshot.data!.docs[newsIndex];
              if (news['to'] != 'news' &&
                  news['to'] != Auth().getUID() &&
                  news['to'] != 'avviso') {
                return const SizedBox.shrink();
              }
              isToYou = news['to'] == Auth().getUID() || news['to'] == 'avviso';

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
