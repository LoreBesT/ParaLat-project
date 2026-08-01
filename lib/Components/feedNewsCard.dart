import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
// import 'package:lecosimo/components/share.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:paralat/screens/dettagli.dart';
import 'package:paralat/Components/socialLinks.dart';

class FeedNewsCard extends StatefulWidget {
  const FeedNewsCard({
    super.key,
    required this.title,
    required this.autore,
    required this.body,
    required this.image,
    required this.snapshot,
    required this.islesson,
  });

  final String title;
  final String autore;
  final String body;
  final String image;
  final DocumentSnapshot snapshot;
  final bool islesson;

  @override
  State<FeedNewsCard> createState() => _FeedNewsCardState();
}

class _FeedNewsCardState extends State<FeedNewsCard> {
  bool isLikePressed = false;
  late List<String> listaTags;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: InkWell(
        onTap: () => _navigateToDetailPage(context, widget.snapshot),
        child: SizedBox(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: AppRadius.circularBorder,
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildImage(widget.image),
                    _buildCardContent(),
                  ],
                ),

                // Badge in alto a destra
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: widget.islesson
                          ? Colors.deepPurple
                          : Colors.blue,
                      borderRadius: AppRadius.circularBorder,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.islesson
                              ? Icons.school
                              : Icons.newspaper,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.islesson ? "Lezione" : "Notizia",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToDetailPage(BuildContext context, DocumentSnapshot news) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsDetailPage(news: news)),
    );
  }

  Widget _buildImage(String imageUrl) {
    return Hero(
      tag: widget.snapshot.id,
      child: Image.network(
        imageUrl,
        loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return SizedBox.shrink();
        // return Image.asset(
        //   'assets/images/logo.png',
        //   scale: 2.3,
        //   fit: BoxFit.cover,
        // );
      },

        errorBuilder: (context, error, stackTrace) {
          return Image.asset('assets/images/logo.png', scale: 2.3);
        },
      ),
    );
  }

  Widget _buildCardContent() {
    return ListTile(
      title: Text(
        widget.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 4,
      ),
      subtitle: Text("di ${widget.autore}"),
      isThreeLine: true,
      leading: IconButton(
        onPressed: () {
          setState(() {
            isLikePressed = !isLikePressed;
          });
        },
        icon: Icon(
                isLikePressed
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: isLikePressed ? Colors.red : null,
                size: 32,
              ),
        alignment: Alignment.centerLeft,
        iconSize: 32,
        padding: const EdgeInsets.all(0),
      ),
      trailing: IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {
                share(
                  '${widget.title}\nScopri questa e tante altre notizie solo su ParaLat.\n⬇️Scaricala ora⬇️\n\nhttps://play.google.com/store/apps/details?id=com.paralat.app',
                );
              },
            ),
    );
  }
}