import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/feedNewsCard.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/screens/HomePage.dart';
import 'package:paralat/screens/impostazioni_page.dart'; // Assicurati di importare la nuova pagina

class NewsGeneralPage extends StatefulWidget {
  const NewsGeneralPage({super.key});

  @override
  State<NewsGeneralPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsGeneralPage> {
  @override
  void initState() {
    super.initState();
    // initBannerAd();
  }

  final int _index = 2;
  // late BannerAd bannerAd;
  // bool isAdLoaded = false;
  // var adUnit =
  //     "ca-app-pub-3940256099942544/9214589741"; //Questo ID è DI TEST. IN PRODUZIONE SOSTITUIRE CON IL REALE ID DI ADMOB!

  // initBannerAd() {
  //   bannerAd = BannerAd(
  //       size: AdSize.banner,
  //       adUnitId: adUnit,
  //       listener: BannerAdListener(
  //         onAdLoaded: (ad) {
  //           setState(() {
  //             isAdLoaded = true;
  //           });
  //         },
  //         onAdFailedToLoad: (ad, error) {
  //           ad.dispose();
  //           print(error);
  //         },
  //       ),
  //       request: AdRequest());

  //   bannerAd.load();
  // }
  bool isToYou = false;
  @override
  Widget build(BuildContext context) {
    List<Widget>? funzioni = Verify().funzioniBottAppBar(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lezioni e Notizie'),
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
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var news = snapshot.data!.docs[index];
              if (news['to'] != 'news' && news['to'] != Auth().getUID() && news['to'] != 'avviso') {
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
                      toYou: news['to'] == Auth().getUID() ? true : false,
                    );
            },
          );
        },
      ),
      // bottomNavigationBar: isAdLoaded
      //     ? SizedBox(
      //         height: bannerAd.size.height.toDouble(),
      //         width: bannerAd.size.width.toDouble(),
      //         child: AdWidget(ad: bannerAd),
      //       )
      //     : SizedBox(),
      bottomNavigationBar: NavFloatBar(
        index: _index,
        funzioni: funzioni,
      ),
    );
  }
}
