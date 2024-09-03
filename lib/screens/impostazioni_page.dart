import 'package:flutter/material.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/screens/assistenza_page.dart';
import 'package:paralat/screens/info_page.dart';
import 'package:paralat/screens/reputazione_page.dart';
import 'package:paralat/screens/sub_page.dart';
import 'package:paralat/screens/theme_page.dart';
import 'package:paralat/screens/work_page.dart';

class ImpostazioniPage extends StatefulWidget {
  const ImpostazioniPage({super.key});

  @override
  State<ImpostazioniPage> createState() => _ImpostazioniPageState();
}

class _ImpostazioniPageState extends State<ImpostazioniPage> {
  int _index = 2;

  // List<Widget> funzioni = [HomePage(), NewsPage(), ImpostazioniPage()];
  @override
  Widget build(BuildContext context) {
    List<Widget>? funzioni = Verify().funzioniBottAppBar(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Impostazioni'),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('Profilo'),
                ),
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text('Altro'),
                ),
                if (Verify().verifyUser(context) !=
                        'Official Member ParaLat Team' &&
                    Verify().verifyUser(context) != 'Premium ParaLat User')
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Versione 1.0.0.0-D\nMade by Lorenzo Della Bona',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Space(heigth: 70),
              ],
            ),
          ),
        ),
        extendBody: true,
        bottomNavigationBar: NavFloatBar(
          index: _index,
          funzioni: funzioni,
        ));
  }
}
