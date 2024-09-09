import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/Components/trans.dart';

class ActionButtons extends StatefulWidget {
  const ActionButtons({
    super.key,
    required this.icona,
    required this.testoMinuscolo,
    this.testoMaiuscolo,
    required this.funzione,
  });
  final IconData icona;
  final String testoMinuscolo;
  final String? testoMaiuscolo;
  final Widget funzione;
  @override
  State<ActionButtons> createState() => _ActionButtonsState();
}

class _ActionButtonsState extends State<ActionButtons> {
  final _nomeVersione = TextEditingController();
  final _testoVersione = TextEditingController();
  final _autore = TextEditingController();
  final _traduzione = TextEditingController();
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
              if (widget.icona == Icons.search_off) {
                navigateWithCustomAnimation(context, widget.funzione);
              } else if (widget.icona == Icons.upload) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                          title: Text('Carica una versione'),
                          content: SizedBox(
                            height: 350,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  controller: _nomeVersione,
                                  decoration: InputDecoration(
                                    label: Text('Nome della Versione'),
                                  ),
                                ),
                                // Space(heigth: 10),
                                TextField(
                                  controller: _testoVersione,
                                  decoration: InputDecoration(
                                    label: Text('Versione'),
                                  ),
                                ),
                                // Space(heigth: 10),
                                TextField(
                                  controller: _autore,
                                  decoration: InputDecoration(
                                    label: Text('Autore'),
                                  ),
                                ),
                                TextField(
                                  controller: _traduzione,
                                  decoration: InputDecoration(
                                    label: Text('Traduzione'),
                                  ),
                                ),
                                Space(heigth: 10),
                                TextButton(
                                    onPressed: () {},
                                    child: Text('Seleziona un documento')),
                                ElevatedButton(
                                    onPressed: () async {
                                      if (_nomeVersione.text.isNotEmpty &&
                                          _testoVersione.text.isNotEmpty &&
                                          _autore.text.isNotEmpty &&
                                          _traduzione.text.isNotEmpty) {
                                        try {
                                          await Auth().uploadVersione(
                                              _nomeVersione.text,
                                              _testoVersione.text,
                                              _autore.text,
                                              _traduzione.text);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Versione caricata con successo. Potrebbero essere necessarie fino a 48h per la verifica.'),
                                            ),
                                          );
                                          _nomeVersione.clear();
                                          _testoVersione.clear();
                                          _autore.clear();
                                          _traduzione.clear();
                                          Navigator.pop(context);
                                        } catch (error) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Errore durante il caricamento della versione. Riprova.'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Compilare tutti i campi!'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: Text('Carica')),
                              ],
                            ),
                          ),
                        ));
              }
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
