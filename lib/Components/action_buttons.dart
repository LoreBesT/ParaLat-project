import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/custom_snackbar.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/space.dart';
import 'dart:io';
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
  String? _nomeFileSelezionato;
  File? _fileSelezionato;
  double? _percentualeCaricamento;
  bool _staCaricamento = false;

  Future<void> _selezionaDocumento(Function setState) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _nomeFileSelezionato = result.files.single.name;
        _fileSelezionato = File(result.files.single.path!);
      });
    }
  }

  Future<void> _caricaDocumentoSuFirebase(StateSetter dialogSetState) async {
    if (_fileSelezionato != null) {
      setState(() {
        _staCaricamento = true;
      });

      try {
        String estensione =
            _nomeFileSelezionato!.substring(_nomeFileSelezionato!.length - 4);
        DateTime now = DateTime.now();
        String newFileName =
            '${_nomeVersione.text}_${_autore.text}_${now.day}-${now.month}-${now.year}_${now.hour}${now.minute}${now.second}${Verify().nameUser(4).replaceAll(' ', '_')}$estensione';
        String nomeFile = newFileName;
        String percorso = 'Versioni/Community/$nomeFile';
        FirebaseStorage storage = FirebaseStorage.instance;
        Reference ref = storage.ref().child(percorso);

        UploadTask uploadTask = ref.putFile(_fileSelezionato!);

        uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
          dialogSetState(() {
            _percentualeCaricamento =
                (snapshot.bytesTransferred / snapshot.totalBytes) * 100;
          });
        });

        await uploadTask.whenComplete(() async {
          String downloadUrl = await ref.getDownloadURL();
          print('File caricato con successo: $downloadUrl');
        });
      } catch (e) {
        print('Errore durante il caricamento del file: $e');
      } finally {
        setState(() {
          _staCaricamento = false;
        });
      }
    } else {}
  }

  void _mostraDialogCaricaVersione(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Carica una versione'),
              content: SizedBox(
                height: 385,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _nomeVersione,
                      decoration: const InputDecoration(
                        label: Text('Nome della Versione'),
                      ),
                    ),
                    TextField(
                      controller: _testoVersione,
                      decoration: const InputDecoration(
                        label: Text('Versione'),
                      ),
                    ),
                    TextField(
                      controller: _autore,
                      decoration: const InputDecoration(
                        label: Text('Autore'),
                      ),
                    ),
                    TextField(
                      controller: _traduzione,
                      decoration: const InputDecoration(
                        label: Text('Traduzione'),
                      ),
                    ),
                    const Space(heigth: 10),
                    TextButton(
                      onPressed: () => _selezionaDocumento(setState),
                      child: Text(
                          _nomeFileSelezionato ?? 'Seleziona un documento'),
                    ),
                    if (_staCaricamento)
                      const CircularProgressIndicator()
                    else
                      ElevatedButton(
                        onPressed: () async {
                          if (_nomeVersione.text.isNotEmpty &&
                              _testoVersione.text.isNotEmpty &&
                              _autore.text.isNotEmpty &&
                              _traduzione.text.isNotEmpty &&
                              _nomeFileSelezionato != 'null') {
                            try {
                              await _caricaDocumentoSuFirebase(setState);
                              await Auth().uploadVersione(
                                _nomeVersione.text,
                                _testoVersione.text,
                                _autore.text,
                                _traduzione.text,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Si è verificato un errore. Riprova'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            } finally {
                              _nomeVersione.clear();
                              _testoVersione.clear();
                              _autore.clear();
                              _traduzione.clear();
                              _percentualeCaricamento = null;
                              _nomeFileSelezionato = null;
                              Navigator.pop(context);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar("Errore, compilare tutti i campi!", type: SnackBarType.error),
                            );
                          }
                        },
                        child: const Text('Carica'),
                      ),
                    if (_percentualeCaricamento != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          '${_percentualeCaricamento?.toStringAsFixed(2)}% completato',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 80,
        child: Card(
          shape:
              const RoundedRectangleBorder(borderRadius: AppRadius.circularBorder),
          child: InkWell(
            borderRadius: AppRadius.circularBorder,
            onTap: () {
              if (widget.icona == Icons.search_off ||
                  widget.icona == Icons.camera_alt ||
                  widget.icona == Icons.filter_alt_rounded ||
                  widget.icona == Icons.report) {
                navigateWithCustomAnimation(context, widget.funzione);
              } else if (widget.icona == Icons.upload) {
                _mostraDialogCaricaVersione(context);
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(widget.icona),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.testoMinuscolo, textAlign: TextAlign.left),
                      Text(
                        widget.testoMaiuscolo ?? '',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 126, 126, 126),
                        ),
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
