import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/news_property.dart';
import 'package:paralat/screens/HomePage.dart';
import 'package:paralat/screens/dettagli.dart';
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

  final int _index = 1;

  List<Widget> funzioni = [const HomePage(), const NewsGeneralPage(), const ImpostazioniPage()];
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
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var news = snapshot.data!.docs[index];
              if (news['to'] != 'everyone' && news['to'] != Auth().getUID()) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding:
                    const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    leading: Icon(
                      Icons.newspaper,
                      color: NewsProperty()
                          .setScadColor(news['imp'] ?? Colors.green),
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
