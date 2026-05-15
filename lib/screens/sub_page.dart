import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/space.dart';

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
    bool isDarkTheme = Auth().isDarkTheme(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  //Fixare il white e modificare il colore a seconda se ci si trova in dark mode o white mode
                  backgroundColor: isDarkTheme? const Color.fromARGB(255, 17, 16, 16) : Colors.white,
                  pinned: true,
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text('ParaLat Premium'),
                    centerTitle: true,
                    background: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          r'assets\images\ParaLat.png',
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const SizedBox(height: 10),
                      RadioListTile<String>(
                        title: const Text('Abbonamento Annuale'),
                        secondary: const Text('2,08€/mese', style: TextStyle(fontSize: 14),),
                        subtitle: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: '35,88€',
                                style: TextStyle(
                                  color: isDarkTheme? Colors.white : Colors.black,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              TextSpan(
                                text: '  24,96€/anno',
                                style: TextStyle(
                                  color: isDarkTheme? Colors.white : Colors.black,
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
                        secondary: const Text('2,99€/mese', style: TextStyle(fontSize: 14),),
                        value: 'Mensile',
                        groupValue: _abbonamentoScelto,
                        onChanged: _handleRadioValueChange,
                      ),
                      const ListTile(
                        leading: Icon(Icons.workspace_premium),
                        title: Text('Accesso al modello Pro di ParaLat AI'),
                        subtitle: Text('Versioni generate in meno tempo grazie ai modelli pro di ParaLat AI'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.ads_click),
                        title: Text('Niente inserzioni'),
                        subtitle: Text('Non vedrai mai alcuna inserzione di alcun tipo'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.attach_money),
                        title: Text('Monetizzazione illimitata'),
                        subtitle: Text('Vendi quanti appunti vuoi senza alcun limite e con commissione ridotta al 5%*'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.auto_stories_outlined),
                        title: Text('Accesso ad approfondimenti esclusivi'),
                        subtitle: Text('Oltre agli articoli disponibili per tutti avrai accesso anche ad approfondimenti esclusivi'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.discord),
                        title: Text('Accesso al canale Discord'),
                        subtitle: Text('Canale Discord riservato ai soli membri Premium con la possibilità di discutere e ricevere spoiler sul progetto'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.contact_support),
                        title: Text('Assistenza Premium'),
                        subtitle: Text('Servizio di assistenza più rapido per i membri premium con risposta garantita entro 24h**'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.rocket_launch),
                        title: Text('Accesso anticipato alle nuove funzionalità'),
                        subtitle: Text('Sarai tra i primi a provare le nuove funzionalità e gli aggiornamenti dell\'applicazione'),
                      ),
                      const ListTile(
                        leading: Icon(Icons.star),
                        title: Text('Badge sul profilo'),
                        subtitle: Text('Badge esclusivo per gli utenti premium'),
                      ),
                      const Text('*Commissioni sulle vendite ridotte dal 30% al 5%.\n**un giorno lavorativo.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 12),),
                      const SizedBox(height: 65),
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
                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all<Color>(const Color.fromARGB(255, 219, 116, 237)), foregroundColor: WidgetStateProperty.all(Colors.white)),
                    child: Text(_abbonamentoScelto == 'Annuale' 
                      ? 'Abbonati a 24,96€/anno' 
                      : 'Abbonati a 2,99€/mese'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
