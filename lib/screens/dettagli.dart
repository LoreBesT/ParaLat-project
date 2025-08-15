import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:paralat/Components/aiFunction.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/socialLinks.dart';

class NewsDetailPage extends StatelessWidget {
  final DocumentSnapshot news;
  const NewsDetailPage({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    // Estrai i dati dalla notizia
    final title = news['title'];
    final body = news['body'];

    final autore = news['autore'];
    dynamic image;
    bool isToYou = false;

    final address = news['to'];
    if (address.toString() == Auth().getUID() || address.toString() == 'avviso') {
      isToYou = true;
      image = 'null'; // Non mostrare l'immagine se è per te
    } else {
      isToYou = false;
      image = news['image'];
    }
    Auth().markAsRead(context, news.id);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        title: Text(isToYou ? 'Avviso' : 'ParaLat News'),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.format_size)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(title),
                _buildDetailImage(image, isToYou),
                const Divider(),
                _buildAuthorAndDate(autore, isToYou),
                const Divider(),
                _buildBody(body),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:
          isToYou ? null : _buildFloatingActionButton(context, body, autore, title),
    );
  }
}

Widget _buildTitle(String title) {
  return Text(
    title,
    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
  );
}

Widget _buildDetailImage(String imageUrl, bool isToYou) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: isToYou
        ? const SizedBox.shrink()
        : ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/logo.png', scale: 2.3);
              },
            ),
          ),
  );
}

Widget _buildAuthorAndDate(String autore, bool isToYou) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: isToYou
                ? const Text('Per te',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ))
                : Text(
                    "di $autore",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 246, 58, 76),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
    ],
  );
}

Widget _buildBody(String body) {
  return Text(body, style: TextStyle(fontSize: 16),);
}

Widget _buildFloatingActionButton(
    BuildContext context, String body, String autore, String title) {
  return PopupMenuButton(
    color: Colors.white,
    elevation: 8,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    icon: Container(
      height: 70,
      width: 70,
      decoration: const BoxDecoration(
        color: Color.fromARGB(0, 255, 255, 255),
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage('assets/images/icon.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    itemBuilder: (context) => [
      PopupMenuItem(
        child: ListTile(
          leading: const Icon(Icons.generating_tokens, color: Colors.blue),
          title: const Text("Riassumi"),
          onTap: () {
            Navigator.pop(context);
            _showSummaryModal(context, body, autore);
          },
        ),
      ),
      PopupMenuItem(
        onTap: () {
          Clipboard.setData(ClipboardData(text: body));
        },
        child: const ListTile(
          leading: Icon(Icons.copy, color: Colors.green),
          title: Text("Copia"),
        ),
      ),
      PopupMenuItem(
        onTap: () {
          share('${title}\n\ndi${autore}\n\n${body}\n\nLeggi questo e tanti altri articoli solo su ParaLat.\n⬇️Scaricalo ora⬇️\n\nhttps://play.google.com/store/apps/details?id=com.paralat.app');
        },
        child: const ListTile(
          leading: Icon(Icons.share, color: Colors.deepPurple),
          title: Text("Condividi"),
        ),
      ),
    ],
  );
}

void _showSummaryModal(BuildContext context, String body, String autore) {
  showModalBottomSheet(
    backgroundColor: Colors.blue.shade50,
    context: context,
    builder: (context) => FutureBuilder<String>(
      future: aiFunction(body, autore),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.maxFinite,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Row(
                      children: [
                        Icon(Icons.generating_tokens,
                            color: Colors.blue, size: 24),
                        Text('  Riassunto AI',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    subtitle: Column(
                      children: [
                        // MarkdownBody(
                        //   data: snapshot.data ?? '',
                        //   selectable: true,
                        // ),
                        Text(snapshot.data ?? ''),
                        Row(
                          children: [
                            const Text(
                              'Powered by ',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                            Image.asset('assets/images/ParaLat.png', scale: 9),
                            IconButton(
                              icon: Icon(Icons.share),
                              onPressed: () {
                                share(
                                    "${snapshot.data!}. Accedi anche te a ParaLat AI.\n⬇️Scarica ora la nostra app⬇️\n\nhttps://play.google.com/store/apps/details?id=com.paralat.app");
                              },
                            ),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: snapshot.data ?? ''));
                              },
                              icon: const Icon(Icons.copy),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.refresh),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    ),
  );
}
