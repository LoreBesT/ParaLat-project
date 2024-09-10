import 'package:flutter/material.dart';

class Feedcard extends StatefulWidget {
  const Feedcard({
    super.key,
    required this.text,
    required this.type,
    required this.autore,
  });
  final String text;
  final String type;
  final String autore;

  @override
  State<Feedcard> createState() => _FeedcardState();
}

class _FeedcardState extends State<Feedcard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Card(
          elevation: 2,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                title: Text(widget.text),
                subtitle: Text(widget.autore),
                leading: Icon(Icons.abc),
                trailing: Icon(Icons.download),
                //Modificare la Card in modo da avere qlc di simile a Feed di Google ed in ogni caso come video 16 corso flutter
              )
            ],
          ),
        ),
      ),
    );
  }
}
