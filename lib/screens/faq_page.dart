import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Faqpage extends StatefulWidget {
  const Faqpage({super.key});

  @override
  State<Faqpage> createState() => _FaqpageState();
}

class _FaqpageState extends State<Faqpage> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQ"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FAQButtons(
                question: 'Cos\'è ParaLat?',
                solutions:
                    'ParaLat è un app volta ad integrare l\'analisi delle versioni latine tramite varie tipologie di assistenza. Le principali sono: \n🟢 ParaLat AI, un sistema di intelligenza artificiale, che svolge integralmente le versioni*\n🟢 Archivio Versioni: Archivio di versioni scolastiche già svolte ordinate per autore\n🟢 Blog: ultime notizie, in tempo reale dal mondo della scuola e dell\'università.\n'),
            FAQButtons(question: 'Come posso collaborare al progetto ParaLat', solutions: 'Collaborare al progetto ParaLat è semplicissimo. Siamo in continua ricerca di persone che vogliano dedicarsi al progetto. Per farlo puoi contattarci tramite i nostri canali social o tramite email. Se sei uno sviluppatore, un professore, uno studente o semplicemente un curioso non esitare a contattarci. Ogni contributo è ben accetto!\nNon dimenticare di seguire i nostri canali social per rimanere aggiornato sulle ultime novità e sugli sviluppi del progetto.\n\nQualora ti piacesse il progetto puoi sostenerci anche con una donazione tramite la nostra pagina Kofi❤️☕.\n'),
            FAQButtons(
                question: 'L\'app va in arresto anomalo',
                solutions:
                    'Il fatto che ParaLat vada di frequente in arresto anomalo è probabilmente dovuto ad una errata configurazione sul tuo dispositivo. Prova per risolvere i seguenti passaggi:\nRiavvia il dispositivo\nSvuota le cache dall\'app\nSe il problema persiste elimina i dati di archiviazione dell\'app\nDisinstalla e reinstalla l\'app\n\n Se questi passaggi non hanno risolto il tuo problema contatta lo sviluppatore.\n'),
            FAQButtons(
                question: 'L\'app consuma troppa batteria',
                solutions:
                    'ParaLat da progetto non dovrebbe consumare troppa batteria. Verifica dunque di non avere altre app in esecuzione che stiano consumando eccessiva batteria. Se accerti che il problema è ParaLat procedi con i seguenti passaggi:\nAttiva la modalità risparmio energetico\nChiudi tutte le app in esecuzione\nAttiva la modalità sospensione avanzata per ParaLat\nDisinstalla e reinstalla ParaLat\n\nSe il tuo dispositivo continua a consumare molta batteria durante l\'esecuzione di ParaLat contatta lo sviluppatore.\n'),
            FAQButtons(
                question: 'L\'app è lenta',
                solutions:
                    'ParaLat può risultare lento per diverse cause od errate configurazioni relative al tuo dispositivo. Per risolvere esegui i seguenti passaggi: \nRiavvia il dispositivo\nSvuota Cache dell\'app\nAssicurati di essere connesso ad una rete internet stabile e mediamente veloce\n\nIn caso di non risoluzione dei problemi contatta lo sviluppatore.\n'),
            FAQButtons(
                question: 'Per usare l\'app serve Internet?',
                solutions:
                    'Si.\nAl momento l\'app è utilizzabile solo con accesso ad Internet. In futuro prevediamo di implementare un sistema di caching così da garantire le funzionalità di base anche senza connessione.'),
          ],
        ),
      ),
    );
  }
}

class FAQButtons extends StatelessWidget {
  const FAQButtons(
      {super.key, required this.question, required this.solutions});
  final String question;
  final String solutions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Theme(
          data: Theme.of(context).copyWith(
            dividerColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
          ),
          child: ExpansionTile(
            trailing: Icon(Icons.expand_more_rounded, size: 30),
            title: Text(
              question,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    top: 4, left: 18, right: 18, bottom: 8),
                child: Text(solutions),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
