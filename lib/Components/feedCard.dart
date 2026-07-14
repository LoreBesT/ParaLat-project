import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';

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
  bool isLikePressed = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: AppRadius.circularBorder),
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                r'assets\images\logo.png',
              ),
              ListTile(
                  title: Text(widget.text),
                  subtitle: Text(widget.autore),
                  leading: IconButton(
                      onPressed: () {
                        setState(() {
                          isLikePressed = !isLikePressed;
                        });
                      },
                      icon: Icon(
                        isLikePressed ? Icons.favorite : Icons.favorite_border,
                        color: isLikePressed ? Colors.red : null,
                      )),
                  trailing: IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: () {
                    },
                  )
                  //Modificare la Card in modo da avere qlc di simile a Feed di Google ed in ogni caso come video 16 corso flutter
                  )
            ],
          ),
        ),
      ),
    );
  }
}
