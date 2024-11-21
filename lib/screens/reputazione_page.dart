// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/modalBottomSheet.dart';
import 'package:paralat/Components/space.dart';
//import 'package:flutter_animate/flutter_animate.dart';

class ProfiloPage extends StatefulWidget {
  const ProfiloPage({super.key});

  @override
  State<ProfiloPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfiloPage> {
  // String? nome = Auth().getUserDisplayName();
  // bool isOfficialMember = false;
  DateTime data_versione = DateTime.now();
  String nome_versione = 'Versione';
  String ofMember = Verify().typeUser(0);
  List<String> sanzioni = [
    'Non è presente alcuna sanzione',
    'Ciao ${Verify().nameUser(0)}.\nHai ricevuto un richiamo disciplinare. Non hai completato i tuoi incarichi per tempo. Non preoccuparti questo è solo un richiamo. In caso di reticenza potresti incorrere in sanzioni.',
    'Ciao ${Verify().nameUser(0)}.\nHai ricevuto una sanzione disciplinare. Non hai rispettato i tuoi incarichi e doveri. Ti sarà assegnata una sanzione consistente nello svolgimento di due parti di analisi nella prossima versioni. In caso di reticenza si rischia di incappare in sanzioni di livello superiore',
    'Ciao ${Verify().nameUser(0)}.\nHai ricevuto una sanzione disciplinare di secondo livello. Hai non rispettato per numerose volte i tuoi incarichi. Ti sarà assegnata una sanzione consistente nello svolgimento di due parti di analisi nella prossima versione. In caso di reticenza sarai espulso/a dal gruppo.',
    'Ciao ${Verify().nameUser(0)}.\nTi comunichiamo che sei stato espulso da ParaLat. Hai violato il regolamento interno del gruppo, non rispettando i tuoi incarichi e doveri. Non avrai più alcun accesso ai livelli admin di ParaLat, i quali rimarranno attivi esclusivamente per le prossime 24 ore.'
  ];

  String getNumber(int sanzione) {
    switch (sanzione) {
      case 0:
        return '0';
      case 1:
      case 4:
        return '1';
      case 2:
      case 5:
        return '2';
      case 3:
      case 6:
      case 8:
      case 9:
        return '3';
      case 7:
        return '4';
      default:
        return 'err';
    }
  }

  List<String> premiMerito = [
    'Non è presente alcun premio di merito',
    'Congratulazioni hai ricevuto una nota di merito. Continua così!',
    'Congratulazioni hai ricevuto una nota di merito di secondo livello! Hai svolto un ottimo lavoro',
    'Congratulazioni hai ricevuto un premio di merito di terzo livello. Hai svolto al miglior modo il tuo compito da admin. Contatta gli altri admin per ricevere un premio di merito',
    'Congratulazioni sei il miglior admin attualmente. Hai ricevuto un premio di merito di quarto livello. Contatta gli altri admin per ricevere un premio esclusivo'
  ];
  Color getIconColor(int sanzione) {
    switch (sanzione) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
      case 3:
        return Colors.orange;
      case 4:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  String getMessage(int sanzione) {
    String greenMessage = 'La tua reputazione è perfetta';
    String yellowMessage = 'Hai ricevuto un richiamo';
    String orangeMessage =
        'Hai ricevuto una sanzione\nPotresti richiare un\'espulsione od un\'altra sanzione';
    String redMessage = 'Sei stato espulso dal progetto';
    switch (sanzione) {
      case 0:
        return greenMessage;
      case 1:
        return yellowMessage;
      case 2:
      case 3:
        return orangeMessage;
      case 4:
        return redMessage;
      default:
        return redMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    String verifiedUser = Verify().verifyUser(context).toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Ciao ${Verify().nameUser(0)}'), //.animate(effects: [ ]), //RICORDA DI INSERIRE ANIMAZIONE AL NOME
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('Sanzioni')
              .doc(Verify().nameUser(0).toLowerCase())
              .snapshots(),
          builder: (context,
              AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            // print(Verify().nameUser(0).toLowerCase());
            var documentData = snapshot.data?.data();
            int sanzione = documentData?['sanzione'] ?? 0;
            int merito = documentData?['merito'] ?? 0;
            // if (documentData == null) {
            //   return Center(child: Text("Utente non trovato"));
            // }
            return SingleChildScrollView(
              child: Align(
                child: Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      margin: const EdgeInsets.all(8),
                      elevation: 7,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text('${Verify().nameUser(4)}'),
                            subtitle: Text('${Verify().verifyUser(context)}'),
                            leading: const Icon(Icons.person),
                            trailing: Icon(
                              Verify().setIcon(context),
                              color: Verify().setColor(context),
                              size: 25,
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            title: const Text(
                                                'Scegli un altro account'),
                                            content: TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Ok'))));
                              },
                              child: const Text(
                                'Cambia Account',
                                style: TextStyle(fontSize: 14),
                              )),
                        ],
                      ),
                    ),
                    if (verifiedUser == ofMember)
                      SizedBox(
                        height: 118,
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          margin: const EdgeInsets.all(8),
                          elevation: 8,
                          child: ListTile(
                            title: const Text('La tua Reputazione'),
                            leading: const Icon(Icons.assessment),
                            subtitle: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      scrollable: true,
                                      title: const Text(
                                        'Dettaglio',
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Sanzioni:',
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            sanzioni[sanzione],
                                            textAlign: TextAlign.left,
                                          ),
                                          const Space(heigth: 5),
                                          const Text(
                                            'Premi di merito:',
                                            style: TextStyle(fontSize: 18),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            premiMerito[merito],
                                            textAlign: TextAlign.left,
                                          ),
                                          const Space(heigth: 10),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Ok'))
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                    'Sanzioni assegnate: ${getNumber(sanzione)}\nPremi di merito: ${merito.toString()}\nProvvedimenti in corso: 0')),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Tooltip(
                                  message: getMessage(sanzione),
                                  child: Icon(
                                    Icons.speed,
                                    color: getIconColor(sanzione),
                                    //sanzione == 0 ?  Colors.green : Colors.orange,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () {
                              Auth().reimpostaPassword(context, false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text(
                                    'Email inviata con successo',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                ),
                              );
                            },
                            child: const Text('Reimposta Password'))),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                          title: const Text(
                                            'Dati account',
                                            textAlign: TextAlign.center,
                                          ),
                                          content: SizedBox(
                                            height: 278,
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Utente: ${Auth().getUserDisplayName()}\nEmail: ${Auth().metaDatas(context, 2)}\nID account:\n${Auth().metaDatas(context, 3)}\nUltimo accesso: ${Auth().metaDatas(context, 1)}\nData creazione account: ${Auth().metaDatas(context, 0)}',
                                                  textAlign: TextAlign.left,
                                                ),
                                                //Text('\nEmail: ${Auth().metaDatas(context, 2)}'),
                                                //Text('\nID account: \n${Auth().metaDatas(context, 3)}'),
                                                // Text('\nData creazione account: \n ${Auth().metaDatas(context, 0)}'),
                                                // Text('\nUltimo accesso:\n${Auth().metaDatas(context, 1)}'),
                                                const SizedBox(
                                                  height: 10,
                                                ),

                                                SizedBox(
                                                  width: 150,
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('Ok')),
                                                ),
                                              ],
                                            ),
                                          )));
                            },
                            child: const Text('Visualizza dati account'))),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () {
                              Auth().signOut(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Esci',
                              style: TextStyle(color: Colors.red),
                            ))),
                    Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () {
                              Auth().deleteAccount(context);
                              Auth().signOut(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Elimina account',
                              style: TextStyle(color: Colors.red),
                            ))),
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          showCustomBottomSheet(context, [
                            'Francesca Bariletto',
                            'Lorenzo Della Bona',
                            'Jacopo Leo',
                            'Luca Martella',
                            'Letizia Marzo',
                            'Nicole Pastore',
                          ]);
                        },
                        icon: const Icon(
                          Icons.note_alt,
                        ),
                        label: const Text("Assegna sanzione"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Azione 2
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.admin_panel_settings),
                        label: const Text("Gestisci gli admin"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.block),
                          label: Text(" Blocca un utente")),
                    )
                  ],
                ),
              );
            },
          );
        },
        label: const Text("Azioni"),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
