import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:paralat/Components/news_property.dart';
import 'package:paralat/screens/dettagli.dart'; // Assicurati di importare la nuova pagina

class ScadenzePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scadenze'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('scadenze')
            .orderBy('scadenza', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          // Raggruppa i documenti per mese
          Map<String, List<DocumentSnapshot>> groupedNews = {};
          for (var doc in snapshot.data!.docs) {
            Timestamp timestamp = doc['scadenza'];
            DateTime date = timestamp.toDate();
            String monthKey = '${date.year}-${date.month.toString().padLeft(2, '0')}'; // Formato yyyy-MM

            if (!groupedNews.containsKey(monthKey)) {
              groupedNews[monthKey] = [];
            }
            groupedNews[monthKey]!.add(doc);
          }

          // Ordina i mesi
          List<String> sortedMonths = groupedNews.keys.toList()
            ..sort((a, b) => b.compareTo(a)); // Ordina per mese in ordine decrescente

          return SingleChildScrollView(
            child: Column(
              children: sortedMonths.map((month) {
                List<DocumentSnapshot> newsList = groupedNews[month]!;
                DateTime monthDate = DateTime.parse('$month-01'); // Crea una data per il mese
                String monthName = '${_getMonthName(monthDate.month)} ${monthDate.year}';

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        monthName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...newsList.map((scadenze) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 0),
                        child: Card(
                          elevation: 4,
                          child: ListTile(
                            leading: Icon(
                              Icons.event,
                              color: NewsProperty().setScadColor(scadenze['imp'] ?? Colors.purple),
                            ),
                            title: Text(scadenze['title']),
                            subtitle: Text('${scadenze['body']}\n', overflow: TextOverflow.ellipsis),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewsDetailPage(news: scadenze, isNews: false,),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }

  // Funzione per ottenere il nome del mese
  String _getMonthName(int month) {
    switch (month) {
      case 1: return 'Gennaio';
      case 2: return 'Febbraio';
      case 3: return 'Marzo';
      case 4: return 'Aprile';
      case 5: return 'Maggio';
      case 6: return 'Giugno';
      case 7: return 'Luglio';
      case 8: return 'Agosto';
      case 9: return 'Settembre';
      case 10: return 'Ottobre';
      case 11: return 'Novembre';
      case 12: return 'Dicembre';
      default: return '';
    }
  }
}
