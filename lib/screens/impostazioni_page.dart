import 'package:flutter/material.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/screens/assistenza_page.dart';
import 'package:paralat/screens/backgroungMusic_page.dart';
import 'package:paralat/screens/info_page.dart';
import 'package:paralat/screens/reputazione_page.dart';
import 'package:paralat/screens/sub_page.dart';
import 'package:paralat/screens/work_page.dart';

class ImpostazioniPage extends StatefulWidget {
  const ImpostazioniPage({super.key});

  @override
  State<ImpostazioniPage> createState() => _ImpostazioniPageState();
}

class _ImpostazioniPageState extends State<ImpostazioniPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Impostazioni'),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text('Profilo'),
            SizedBox(
                width: double.infinity,
                child: Button(
                    icona: Icons.account_circle_sharp,
                    funzione: ProfiloPage(),
                    testo: '   Account')),
            SizedBox(
                width: double.infinity,
                child: Button(
                    icona: Icons.language,
                    funzione: WorkPage(),
                    testo: '   Cambia lingua')),
            SizedBox(
                width: double.infinity,
                child: Button(
                    icona: Icons.accessibility_new,
                    funzione: WorkPage(),
                    testo: '   Accessibilità')),
            SizedBox(
              height: 20,
            ),
            Text('Personalizzazione'),
            SizedBox(
                width: double.infinity,
                child: Button(
                    icona: Icons.format_paint_rounded,
                    funzione: WorkPage(),
                    testo: '   Modifica tema')),
            SizedBox(
              width: double.infinity,
              child: Button(
                  icona: Icons.music_note,
                  funzione: MusicPage(),
                  testo: '   Attiva background music'),
            ),
            SizedBox(
              height: 20,
            ),
            Text('Altro'),
            if(Verify().verifyUser(context) != 'Official Member ParaLat Team' && Verify().verifyUser(context) != 'Premium ParaLat User')
            SizedBox(
                width: double.infinity,
                child: Button(
                  icona: Icons.diamond_outlined,
                  funzione: SubPage(),
                  testo: '    ParaLat Premium',
                )),
            SizedBox(
                width: double.infinity,
                child: Button(
                  icona: Icons.help,
                  funzione: AssistenzaPage(),
                  testo: '    Assistenza',
                )),
            SizedBox(
                width: double.infinity,
                child: Button(
                    icona: Icons.info,
                    funzione: InfoPage(),
                    testo: '     Credits')),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Versione 1.0.0\nMade by Lorenzo Della Bona',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center,
                    ))),
          ],
        ),
      ),
    );
  }
}
