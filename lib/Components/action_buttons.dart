import 'package:flutter/material.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({
    super.key,
    required this.icona,
    required this.testoMinuscolo,
    this.testoMaiuscolo,
    this.funzione,
  });
  final IconData icona;
  final String testoMinuscolo;
  final String? testoMaiuscolo;
  final Widget? funzione;
  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(
        height: 80,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () {
              // if(widget.icona == Icons.)
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(widget.icona),
                  SizedBox(
                    width: 8,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.testoMinuscolo,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        widget.testoMaiuscolo ?? '',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 126, 126, 126)),
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
}
