// ignore_for_file: prefer_typing_uninitialized_variables
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/screens/auth_page.dart';
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
  String ofMember = 'Official Member ParaLat Team';
  List<String> sanzioni = [
    'Non è presente alcuna sanzione',
    'Hai ricevuto in data 26/07/2024 una sanzione quantitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta. Questo è solo un richiamo. In caso di reiterazione sia nel breve che nel lungo termine sarai effettivamente sanzionato',
    'Hai ricevuto in data 26/07/2024 una sanzione quantitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta. Non hai svolto per la seconda volta una versione.Ti sarà comminata una sanzione nella prossima versione consistente nello svolgimento di una parte in più della stessa. In caso di reiterazione sia nel breve che nel lungo termine è prevista l\'espulsione con effetto immediato dal gruppo con il divieto di rientrarci',
    'Hai ricevuto in data 26/07/2024 una sanzione quantitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta. Non hai svolto per la terza volta una versione. A causa delle tue inadempienze sei espulso con effetto immediato dal gruppo. Ricorda che ti sarà inibito l\'accesso a qualsiasi software ParaLat a livello admin. Potrai continuare ad usare ParaLat App come un normale utente.',
    'Hai ricevuto in data 26/07/2024 una sanzione qualitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta nella sua interezza correttamente o completamente. Non preoccuparti questo è solo un richiamo e non avrà alcun peso sulla tua reputazione. Un saluto dal team ParaLat',
    'Hai ricevuto in data 26/07/2024 una sanzione qualitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta nella sua interezza correttamente o completamente. Questo è il tuo secondo richiamo qualitativo. In caso di una successiva rilevazione di incorrettezza sarai effettivamente sanzionato',
    'Hai ricevuto in data 26/07/2024 una sanzione qualitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta nella sua interezza correttamente o completamente. Questo è il tuo terzo richiamo qualitativo. Ti sarà comminata una sanzione nella prossima versione consistente nello svolgimento di una parte in più della stessa. In caso di reiterazione sia nel breve che nel lungo termine è prevista l\'espulsione con effetto immediato dal gruppo con il divieto di rientrarci',
    'Hai ricevuto in data 26/07/2024 una sanzione qualitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta. Questo è il tuo quarto richiamo qualitativo. A causa delle tue inadempienze sei espulso con effetto immediato dal gruppo. Ricorda che ti sarà inibito l\'accesso a qualsiasi software ParaLat a livello admin. Potrai continuare ad usare ParaLat App come un normale utente.',
    'Hai ricevuto in data 26/07/2024 una sanzione quantitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta. Questa è la terza sanzione che ricevi sul tuo profilo. Sei dunque espulso con effetto immediato dal gruppo. Ricorda che ti sarà inibito l\'accesso a qualsiasi software ParaLat a livello admin. Potrai continuare ad usare ParaLat App come un normale utente.',
    'Hai ricevuto in data 26/07/2024 una sanzione qualitativa. La tua parte dell\'ultima versione assegnata, Carpe Diem, non risulta essere svolta nella sua interezza corretamente o completamente. Questa è la terza sanzione che ricevi sul tuo profilo. Sei dunque espulso con effetto immediato dal gruppo. Ricorda che ti sarà inibito l\'accesso a qualsiasi software ParaLat a livello admin. Potrai continuare ad usare ParaLat App come un normale utente.'
  ];

  List<String> premiMerito = [
    'Non è presente alcun premio di merito',
    'Congratulazioni sei uno tra i migliori admin ParaLat, continua così!',
    'Congratulazioni in data 26/07/2024 hai ricevuto un premio di merito. Sei l\'admin ParaLat con la reputazione più alta di questo mese. Ora rilassati pure. Non sei tenuto/a a svolgere la prossima versione. Ci penseranno gli altri a svolgerla per te!',
    'Congratulazione in data 26/07/2024 risulti essere stato l\'admin ParaLat con la reputazione più alta in 3 mesi. Hai diritto pertanto all\'accesso a dei nuovi privilegi: \nNon svolgere la versioni per 2 volte(non consecutive) entro i prossimi 3 mesi\nAccesso illimitato alle funzionalità di amministratore Whatsapp\nDedica speciale in-app visibile a tutti gli utenti per 3 mesi',
  ];
  Color getIconColor(int sanzione) {
    switch (sanzione) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow;
      case 2:
      case 6:
        return Colors.orange;
      case 3:
      case 9:
      case 8:
      case 7:
        return Colors.red;

      default:
        return Colors.red;
    }
  }

  String getMessage(int sanzione) {
    String greenMessage = 'La tua reputazione è perfetta';
    String yellowMessage = 'Hai ricevuto un richiamo';
    String orangeMessage =
        'Reputazione a rischio\nHai ricevuto una sanzione\nPotresti richiare un\'espulsione';
    String redMessage = 'Sei stato espulso dal progetto';
    switch (sanzione) {
      case 0:
        return greenMessage;
      case 1:
        return yellowMessage;
      case 2:
      case 6:
        return orangeMessage;
      case 3:
      case 7:
      case 8:
      case 9:
        return redMessage;
      default:
        return redMessage;
    }
  }

  @override
  Widget build(BuildContext context) {
    String verifiedUser = Verify().verifyUser(context);
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
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
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
              return Align(
                child: Column(
                  children: [
                    Card(
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
                                                child: const Text(
                                                    'Accedi come guest'))));
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
                                child: const Text(
                                    'Sanzioni assegnate: 1\nPremi di merito: 0\nProvvedimenti in corso: 0')),
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
                    if (Verify().nameUser(0) != 'Guest')
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
                    if (Verify().nameUser(0) != 'Guest')
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
              );
            }));
  }
}
