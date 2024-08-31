import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/screens/chat_page.dart';
import 'package:paralat/screens/faq_page.dart';
import 'package:paralat/screens/infoapp_page.dart';
import 'package:paralat/screens/terms.dart';

class AssistenzaPage extends StatefulWidget {
  const AssistenzaPage({super.key});

  @override
  State<AssistenzaPage> createState() => _AssistenzaPageState();
}

class _AssistenzaPageState extends State<AssistenzaPage> {
  final _titolo = TextEditingController();
  final _segnalazione = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assistenza'),
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Space(heigth: 10),
              Button(
                  icona: Icons.help_center_outlined,
                  funzione: FaqPage(),
                  testo: 'FAQ'),
              Space(heigth: 10),
              Button(
                  icona: Icons.privacy_tip,
                  funzione: TermsPage(),
                  testo: 'Termini e Privacy'),
              Space(heigth: 10),
              // Button(
              //     icona: Icons.feedback_outlined,
              //     funzione: WorkPage(),
              //     testo: 'Invia una segnalazione'),
              Container(
                width: double.infinity,
                child: Animate(
                  effects: [ScaleEffect()],
                  child: ElevatedButton(
                      style:
                          ButtonStyle(animationDuration: Duration(seconds: 1)),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  title: Text(
                                    'Invia una segnalazione',
                                    textAlign: TextAlign.center,
                                  ),
                                  content: SizedBox(
                                    height: 200,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextField(
                                          controller: _titolo,
                                          decoration: const InputDecoration(
                                              label: Text('Titolo')),
                                        ),
                                        const Space(heigth: 20, width: 40),
                                        TextField(
                                          controller: _segnalazione,
                                          decoration: const InputDecoration(
                                              label: Text('Segnalazione')),
                                        ),
                                        Space(heigth: 12.8),
                                        ElevatedButton(
                                          child: Text('Invia'),
                                          onPressed: () {
                                            Auth().createReport(
                                                _titolo.text,
                                                _segnalazione.text,
                                                Verify().nameUser(4).toString(),
                                                context);
                                            Navigator.pop(context);
                                            _titolo.clear();
                                            _segnalazione.clear();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.contact_support),
                            Text(
                              '  Invia una segnalazione',
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Space(heigth: 10),
              Button(
                  icona: Icons.info_outline,
                  funzione: InfoappPage(),
                  testo: 'Info app'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const ChatPage(),
              ),
            );
          },
          label: const Text('Contattaci'),
          icon: const Icon(Icons.chat),
        ));
  }
}
