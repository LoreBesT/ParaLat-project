// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:paralat/Components/trans.dart';
import 'package:paralat/screens/sub_page.dart';

class Button extends StatefulWidget {
  ///Bottone per il drawer personalizzabile con icona, testo e pagina di destinazione
  const Button(
      {super.key,
      required this.icona,
      required this.funzione,
      required this.testo,
      this.isPremium});

  final Widget funzione;
  final IconData icona;
  final String testo;
  final bool? isPremium;

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          animationDuration: const Duration(seconds: 1),
        ),
        onPressed: () {
          
          if (widget.isPremium != null && widget.isPremium == true ||
              widget.testo != 'Archivio Versioni') {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute<void>(
            //     builder: (context) => widget.funzione,
            //   ),
            // );
            navigateWithCustomAnimation(context, widget.funzione);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => SubPage(),
              ),
            );
          }
        },
        child: Animate(
          effects: const [ScaleEffect()],
          child: Row(
            children: [
              Icon(widget.icona),
              const SizedBox(width: 8),
              Text('${widget.testo}  '),
              if (widget.isPremium != null && widget.isPremium == false)
                Icon(Icons.diamond_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
