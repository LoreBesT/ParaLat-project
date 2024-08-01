import 'package:flutter/material.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQ'),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const ExpansionPanelListExample(),
    );
  }
}

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<String> headers = [
  'Cos\'è ParaLat?',
  'L\'app va in arresto anomalo',
  'l\'app consuma troppa batteria',
  'L\'app è lento',
  'ParaLat non si apre',
  'Le versioni non sono corrette',
  'ParaLat Ai non è disponibile nel mio paese',
  'L\'archivio versioni non si apre'
];
List<String> values = [
  'ParaLat è un app volta ad integrare l\'analisi delle versioni latine tramite varie tipologie di assistenza. Le principali sono: \n ParaLat AI, un sistema di intelligenza artificiale basato su Gemini, che svolge integralmente le versioni*\nArchivio Versioni: Archivio di versioni scolastiche già svolte ordinate per autore\n\n*Gemini è un modello di IA basato su una rete neurale di proprietà di Google LLC. Le risposte potrebbero essere errate.\n',
  'Il fatto che ParaLat vada di frequente in arresto anomalo è probabilmente dovuto ad una errata configurazione sul tuo dispositivo. Prova per risolvere i seguenti passaggi:\nRiavvia il dispositivo\nSvuota le cache dall\'app\nSe il problema persiste elimina i dati di archiviazione dell\'app\nDisinstalla e reinstalla l\'app\n\n Se questi passaggi non hanno risolto il tuo problema contatta lo sviluppatore.\n',
  'ParaLat da progetto non dovrebbe consumare troppa batteria. Verifica dunque di non avere altre app in esecuzione che stiano consumando eccessiva batteria. Se accerti che il problema è ParaLat procedi con i seguenti passaggi:\nAttiva la modalità risparmio energetico\nChiudi tutte le app in esecuzione\nAttiva la modalità sospensione avanzata per ParaLat\nDisinstalla e reinstalla ParaLat\n\nSe il tuo dispositivo continua a consumare molta batteria durante l\'esecuzione di ParaLat contatta lo sviluppatore.\n',
  'ParaLat può risultare lento per diverse cause od errate configurazioni relative al tuo dispositivo. Per risolvere esegui i seguenti passaggi: \nRiavvia il dispositivo\nSvuota Cache dell\'app\nAssicurati di essere connesso ad una rete internet stabile e mediamente veloce\n\nIn caso di non risoluzione dei problemi contatta lo sviluppatore.\n',
  'Ciao',
  'Ciaoo',
  'Salve',
  'Hello'
];

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: headers[index],
      expandedValue: values[index],
    );
  });
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key});

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  final List<Item> _data = generateItems(8);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
