import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:lecosimo/components/share.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:paralat/screens/dettagli.dart';
import 'package:paralat/Components/socialLinks.dart';


class FeedNewsCard extends StatefulWidget {
  const FeedNewsCard(
      {super.key,
      required this.title,
      required this.autore,
      required this.body,
      required this.image, //Togliere required ad image
      required this.snapshot,
      required this.toYou});

  final String title;
  final String autore;
  final String body;
  final String image;
  final DocumentSnapshot snapshot;
  final bool toYou;

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
              borderRadius: BorderRadius.circular(20),
            ),
            // elevation: 2,
            clipBehavior: Clip.hardEdge,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                widget.toYou
                    ? const SizedBox.shrink()
                    : _buildImage(widget.image),
                _buildCardContent(),
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
        maxLines: widget.toYou ? 3 : 4,
      ),
      subtitle: widget.toYou
          ? const Text(
              'Per te',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w800),
            )
          : Text("di ${widget.autore}"),
      isThreeLine: true,
      leading: IconButton(
        onPressed: () {
          setState(() {
            isLikePressed = !isLikePressed;
          });
        },
        icon: widget.toYou
            ? Icon(Icons.notifications, color: Colors.yellow[600], size: 32)
            : Icon(
                isLikePressed ? Icons.favorite : Icons.favorite_border,
                color: isLikePressed ? Colors.red : null,
                size: 32,
              ),
        alignment: Alignment.centerLeft,
        iconSize: 32,
        padding: const EdgeInsets.all(0),
      ),
      trailing: widget.toYou
          ? const SizedBox.shrink()
          : IconButton(
              icon: const Icon(
                Icons.share,
              ),
              onPressed: () {
                share('${widget.title}\nScopri questa e tante altre notizie solo su ParaLat.\n⬇️Scaricala ora⬇️\n\nhttps://play.google.com/store/apps/details?id=com.paralat.app');
              },
            ),
    );
  }
}
