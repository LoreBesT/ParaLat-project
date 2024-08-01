import 'package:flutter/material.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/screens/chat_page.dart';
import 'package:paralat/screens/faq_page.dart';
import 'package:paralat/screens/infoapp_page.dart';
import 'package:paralat/screens/terms.dart';
import 'package:paralat/screens/work_page.dart';

class AssistenzaPage extends StatefulWidget {
  const AssistenzaPage({super.key});

  @override
  State<AssistenzaPage> createState() => _AssistenzaPageState();
}

class _AssistenzaPageState extends State<AssistenzaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Assistenza'),
          toolbarHeight: 100,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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
              Button(
                  icona: Icons.feedback_outlined,
                  funzione: WorkPage(),
                  testo: 'Invia una segnalazione'),
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
