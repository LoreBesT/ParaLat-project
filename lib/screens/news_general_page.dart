import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/feedNewsCard.dart';
import 'package:paralat/Components/navfloatbar.dart';

class NewsGeneralPage extends StatefulWidget {
  const NewsGeneralPage({super.key});

  @override
  State<NewsGeneralPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsGeneralPage> {
  @override
  void initState() {
    super.initState();
  }

  final int _index = 2;
  bool isToYou = false;
  @override
  Widget build(BuildContext context) {
    List<Widget>? funzioni = Auth().funzioniBottAppBar(context);
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
              return isToYou
                  ? const SizedBox.shrink()
                  : FeedNewsCard(
                      title: news['title'],
                      autore: news['autore'],
                      body: news['body'],
                      snapshot: news,
                      image: isToYou ? 'null' : news['image'],
                      islesson: news['islesson'],
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
