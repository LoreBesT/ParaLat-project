import 'package:flutter/material.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/Components/space.dart';
import 'package:paralat/screens/work_page.dart';

class SubPage extends StatefulWidget {
  const SubPage({super.key});

  @override
  State<SubPage> createState() => _SubPageState();
}

class _SubPageState extends State<SubPage> {
  String? _abbonamentoScelto = 'Mensile';

  void _handleRadioValueChange(String? value) {
    setState(() {
      _abbonamentoScelto = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 250,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('ParaLat Premium'),
                  background: Column(
                    children: [
                      Space(heigth: 100),
                      Image.asset(
                        r'assets\images\ParaLat.png',
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Space(heigth: 10),
                    RadioListTile<String>(
                      title: const Text('Abbonamento Annuale'),
                      secondary: Text('2,08€/mese', style: TextStyle(fontSize: 14),),
                      subtitle: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '35,88€',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            TextSpan(
                              text: '  24,96€/anno',
                              style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      value: 'Annuale',
                      groupValue: _abbonamentoScelto,
                      onChanged: _handleRadioValueChange,
                    ),
                    RadioListTile<String>(
                      title: const Text('Abbonamento Mensile'),
                      secondary: Text('2,99€/mese', style: TextStyle(fontSize: 14),),
                      value: 'Mensile',
                      groupValue: _abbonamentoScelto,
                      onChanged: _handleRadioValueChange,
                    ),
                    ListTile(
                      leading: Icon(Icons.archive_outlined),
                      title: Text('Archivio Versioni'),
                      subtitle: Text('Sblocca l\'accesso a decine di versioni revisionate e corrette da esperti'),
                    ),
                    ListTile(
                      leading: Icon(Icons.download),
                      title: Text('Download delle versioni'),
                      subtitle: Text('Scarica tutte le versioni dall\'archivio che desideri e sfruttale come meglio desideri*'),
                    ),
                    ListTile(
                      leading: Icon(Icons.workspace_premium),
                      title: Text('Accesso al modello Pro di ParaLat AI'),
                      subtitle: Text('Versioni più corrette e generate in meno tempo grazie a ParaLat AI pro - based on Google Gemini 1.5 pro'),
                    ),
                    ListTile(
                      leading: Icon(Icons.badge),
                      title: Text('Sblocca Badge unlimited'),
                      subtitle: Text('Hai accesso illimitato a ParaLat Cards. Registra tutte le tessere,badge o carte che vuoi. Potrai usarle sempre e saranno sempre disponibili**.'),
                    ),
                    ListTile(
                      leading: Icon(Icons.ads_click),
                      title: Text('Niente inserzioni'),
                      subtitle: Text('Non vedrai mai alcuna inserzione di alcun tipo'),
                    ),
                    ListTile(
                      leading: Icon(Icons.discord),
                      title: Text('Accesso al canale Discord esclusivo'),
                      subtitle: Text('Canale Discord esclusivo per i membri Premium con la possibilità di discutere e ricevere spoiler sul progetto esclusivi'),
                    ),
                    ListTile(
                      leading: Icon(Icons.star),
                      title: Text('Badge sul profilo'),
                      subtitle: Text('Badge esclusivo per gli utenti premium'),
                    ),
                    Text('*I file scaricati sono da considerarsi ad uso esclusivo personale. Una eventuale diffusione non autorizzata è punibile penalmente.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12),),
                    Text('**ParaLat Cards è disponibile anche per i free users con il limite di 3 carte registrabili e massimo 1 utilizzabile al giorno.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12),),
                    Space(heigth: 65),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Azione da eseguire quando il pulsante viene premuto
                  },
                  child: Text(_abbonamentoScelto == 'Annuale' 
                    ? 'Abbonati a 24,96€/anno' 
                    : 'Abbonati a 2,99€/mese'),
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(Color.fromARGB(255, 219, 116, 237)), foregroundColor: WidgetStateProperty.all(Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
