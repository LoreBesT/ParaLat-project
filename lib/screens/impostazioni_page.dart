import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/socialLinks.dart';
import 'package:paralat/screens/assistenza_page.dart';
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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Profilo'),
                  ),
                  const SizedBox(
                      width: double.infinity,
                      child: Button(
                          icona: Icons.account_circle_sharp,
                          funzione: ProfiloPage(),
                          testo: '   Account')),
                  const SizedBox(
                      width: double.infinity,
                      child: Button(
                          icona: Icons.language,
                          funzione: WorkPage(),
                          testo: '   Cambia lingua')),
                  // const SizedBox(
                  //     width: double.infinity,
                  //     child: Button(
                  //         icona: Icons.accessibility_new,
                  //         funzione: WorkPage(),
                  //         testo: '   Accessibilità')),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text('Altro'),
                  ),
                  // if (Verify().verifyUser(context) != Verify().typeUser(0))
                  //   const SizedBox(
                  //       width: double.infinity,
                  //       child: Button(
                  //         icona: Icons.diamond,
                  //         funzione: SubPage(),
                  //         testo: '    ParaLat Premium',
                  //       )),
                  SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsetsGeometry.only(bottom: 15),
                        child: SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            style: const ButtonStyle(
                              animationDuration: Duration(seconds: 1),
                            ),
                            onPressed: () {
                              openSite(context, 'https://ko-fi.com/paralatstudy');
                            },
                            child: Animate(
                              effects: const [ScaleEffect()],
                              child: const Row(
                                children: [
                                  Icon(
                                    Icons.favorite,
                                  ),
                                  SizedBox(width: 8),
                                  Text('    Fai una donazione'),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                  const SizedBox(
                      width: double.infinity,
                      child: Button(
                        icona: Icons.help,
                        funzione: AssistenzaPage(),
                        testo: '    Assistenza',
                      )),
                  const SizedBox(
                      width: double.infinity,
                      child: Button(
                          icona: Icons.info,
                          funzione: InfoPage(),
                          testo: '     Credits')),
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Versione 1.0.0.0-D\nMade by Lorenzo Della Bona',
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Space(heigth: 10),
                ],
              ),
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
