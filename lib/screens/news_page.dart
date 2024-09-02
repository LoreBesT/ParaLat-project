import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/news_property.dart';
import 'package:paralat/screens/dettagli.dart';

class NewsPage extends StatefulWidget {
  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin {
  int _index = 1;
  late TabController _tabController;
  bool _showFAB = false;

  final _title = TextEditingController();
  final _body = TextEditingController();
  final _color = TextEditingController();
  final _dateTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _showFAB = _tabController.index == 1;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? funzioni = Verify().funzioniBottAppBar(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Comunicazioni'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Notizie'),
            Tab(text: 'Scadenze'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNewsTab(),
          _buildScadenzeTab(),
        ],
      ),
      floatingActionButton: _showFAB
          ? FloatingActionButton(
              onPressed: () {
                _showAddScadenzaDialog(context);
              },
              child: Icon(Icons.edit),
            )
          : null,
      bottomNavigationBar: NavFloatBar(
        index: _index,
        funzioni: funzioni,
      ),
    );
  }

  Widget _buildNewsTab() {
    return StreamBuilder(
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
            if (news['to'] != 'everyone' &&
                news['to'] != Verify().nameUser(0).toLowerCase()) {
              return SizedBox.shrink();
            }
            return Padding(
              padding:
                  const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 0),
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
    );
  }

  Widget _buildScadenzeTab() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('scadenze')
          .orderBy('scadenza', descending: true)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        Map<String, List<DocumentSnapshot>> groupedNews = {};
        for (var doc in snapshot.data!.docs) {
          Timestamp timestamp = doc['scadenza'];
          DateTime date = timestamp.toDate();
          String monthKey =
              '${date.year}-${date.month.toString().padLeft(2, '0')}';

          if (!groupedNews.containsKey(monthKey)) {
            groupedNews[monthKey] = [];
          }
          groupedNews[monthKey]!.add(doc);
        }

        List<String> sortedMonths = groupedNews.keys.toList()
          ..sort((a, b) => b.compareTo(a));

        return SingleChildScrollView(
          child: Column(
            children: sortedMonths.map((month) {
              List<DocumentSnapshot> newsList = groupedNews[month]!;
              DateTime monthDate = DateTime.parse('$month-01');
              String monthName =
                  '${_getMonthName(monthDate.month)} ${monthDate.year}';

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      monthName,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  ...newsList.map((scadenze) {
                    Timestamp timestamp = scadenze['scadenza'];
                    DateTime scadenzaDate = timestamp.toDate();
                    String scadenzaFormatted =
                        '${scadenzaDate.day.toString().padLeft(2, '0')} ${_getMonthName(scadenzaDate.month.toInt())} ${scadenzaDate.year}';

                    return Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 0),
                      child: Card(
                        elevation: 4,
                        child: ListTile(
                          leading: Icon(
                            Icons.event,
                            color: NewsProperty()
                                .setScadColor(scadenze['imp'] ?? Colors.purple),
                          ),
                          title: Text(scadenze['title']),
                          subtitle: Text(scadenzaFormatted,
                              overflow: TextOverflow.ellipsis),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewsDetailPage(
                                  news: scadenze,
                                  isNews: false,
                                ),
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
    );
  }

  void _showAddScadenzaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          'Aggiungi un evento',
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _title,
                decoration: const InputDecoration(label: Text('Titolo')),
              ),
              TextField(
                controller: _body,
                decoration: const InputDecoration(
                    label: Text('Contenuto (facoltativo)')),
              ),
              TextField(
                controller: _color,
                decoration: const InputDecoration(label: Text('Colore')),
              ),
              TextField(
                controller: _dateTimeController,
                readOnly: true,
                decoration: const InputDecoration(label: Text('Data scadenza')),
                onTap: () => _selectDateTime(context),
              ),
              SizedBox(height: 12.8),
              ElevatedButton(
                child: Text('Aggiungi'),
                onPressed: () {
                  if (_dateTimeController.text.isNotEmpty &&
                      _title.text.isNotEmpty &&
                      _color.text.isNotEmpty) {
                    Navigator.pop(context);
                    DateTime parsedDateTime =
                        DateTime.parse(_dateTimeController.text);
                    Auth().createEvent(
                        _title.text, _body.text, _color.text, parsedDateTime);
                    _title.clear();
                    _body.clear();
                    _color.clear();
                    _dateTimeController.clear();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Compilare tutti i campi!'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      final DateTime finalDateTime = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        0,
        0,
      );
      _dateTimeController.text = finalDateTime.toString();
    }
  }

  String _getMonthName(int month) {
    switch (month) {
      case 1:
        return 'Gennaio';
      case 2:
        return 'Febbraio';
      case 3:
        return 'Marzo';
      case 4:
        return 'Aprile';
      case 5:
        return 'Maggio';
      case 6:
        return 'Giugno';
      case 7:
        return 'Luglio';
      case 8:
        return 'Agosto';
      case 9:
        return 'Settembre';
      case 10:
        return 'Ottobre';
      case 11:
        return 'Novembre';
      case 12:
        return 'Dicembre';
      default:
        return '';
    }
  }
}
