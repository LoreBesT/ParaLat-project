import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/socialLinks.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/screens/Faq_page.dart';
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
  // bool _isLoading = false;

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
            Button(
                icona: Icons.help_center_outlined,
                funzione: Faqpage(),
                testo: 'FAQ'),
            Button(
                icona: Icons.privacy_tip,
                funzione: TermsPage(),
                testo: 'Termini e Privacy'),
            Button(
                icona: Icons.info_outline,
                funzione: InfoappPage(),
                testo: 'Info app'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          sendMail(context,'paralatstudy@gmail.com', 'Richiesta di supporto - ${Verify().nameUser(4)}', 'Non eliminare o modificare queste informazioni.\n\n______________________\n\nNome e Cognome: ${Verify().nameUser(4)}\n\nUID: ${Auth().getUID()}\n______________________\n\nDescrivi qui il tuo problema:\n');
        },
        label: const Text('Contattaci'),
        icon: const Icon(Icons.chat),
      ),
    );
  }
}
