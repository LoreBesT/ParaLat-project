// ignore_for_file: file_names
import 'package:flutter/material.dart';

class RoundButtons extends StatefulWidget {
  ///Bottone per il drawer personalizzabile con icona, testo e pagina di destinazione
  RoundButtons({
    super.key,
    this.icona1,
    this.funzione,
    required this.icona2,
    required this.music,
    required this.left,
    required this.top,
  });

  final Function? funzione;
  final IconData? icona1;
  final IconData icona2;
  bool music;
  final double left;
  final double top;

  @override
  State<RoundButtons> createState() => _RoundButtonsState();
}

class _RoundButtonsState extends State<RoundButtons> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      child: InkWell(
        onTap: () {
          setState(() {
            widget.funzione;
          });
        },
        child: Card(
          shape: const CircleBorder(),
          elevation: 3,
          child: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color.fromARGB(255, 211, 146, 239),
            ),
            child: widget.music
                ? Icon(
                    widget.icona1,
                    size: 30,
                  )
                : Icon(
                    widget.icona2,
                    size: 30,
                  ),
          ),
        ),
      ),
    );
  }
}
