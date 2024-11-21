import 'dart:async';
import 'dart:io';
import 'package:docx_template/docx_template.dart' as docxTemp;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class GeminiApiPage extends StatefulWidget {
  @override
  _GeminiApiPageState createState() => _GeminiApiPageState();
}

class _GeminiApiPageState extends State<GeminiApiPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages =
      []; // Cambia a lista di mappe per tracciare chi ha inviato il messaggio
  final String apiKey =
      'AIzaSyA8XweciTZnjycM2iwHRSzCle-3YAYzV2o'; // Inserisci la tua API Key
  bool _isLoading = false;

  Future<void> _fetchResponse(String text) async {
    final model = GenerativeModel(model: "gemini-1.5-pro", apiKey: apiKey);
    final completeInput =
        'Ciao ho questa versione che devi analizzare secondo le indicazioni che ti do. L\'analisi la incollerò in un file word, perciò dedica una riga per l\'analisi di ciascuna parola. L\'analisi dovrà essere svolta così: subito dopo la parola metti il complemento(oggetto, specificazione, termine, stato in luogo, soggetto ecc... ecc..) per nomi, e pronomi e aggettivi(per gli aggettivi specifica scrivendo ad esempio: Att. del compl di termine); per i verbi metti il modo(indicativo, congiuntivo ecc.. ecc..) per il resto metti invece la parte del discorso(congiunzione, interazione, avverbio ecc...). Dopo tale parte metti il caso per nomi, pronomi e aggettivi ed il tempo per i verbi. In seguito metti il genere(Indica il maschile con M ed il femminile con F) mentre per i verbi metti la persona(Indicandola con 1, 2, 3). Dopo metti il numero(indicandolo con S per il singolare e P per il plurale). Dopo metti per i verbi il paradigma del verbo(Ricorda il paradigma è costituito da 5 voci del verbo: 1 persona indicativo presente, 2 persona indicativo presente, 1 persona indicativo perfetto, supino, infinito presente) mentre per il resto la derivazione(nominativo e genitivo singolare della parola in questione). Infine metti  la corrispettiva traduzione italiana di ogni parola. Un ultima precisazione non fornirmi l\'output in markdown e fornisci l\'analisi completa NON DEVI BLOCCARTI A META\' ANALISI. N.B. Se qualcuna delle precedenti voci dovesse risultare vuota allora non metti direttamente la voce successiva. Questo è un esempio di come fare l\'analisi: Vocas = indicativo, presente 2 S, voco-vocas-vocavi-vocatum-vocare trad: chiami. Oppure per una congiunzione: et = congiunzione trad: e. Per un nome invece ad esempio: rosam = Compl. Oggetto, accusativo, F, S, rosa-rosae, trad: la rosa. Questa è la versione da analizzare: $text';
    setState(() {
      _messages.add({"sender": "user", "text": text});
      _isLoading = true;
    });

    try {
      final response = await model.generateContent([
        Content.text(completeInput),
      ]);
      String response2 = response.text!;
      String? response3 = response2.replaceAll("*", "").replaceAll("#", "");
      String? response4 =
          '${response3}\n\nVersione generata con ParaLat AI\nParaLat AI può commettere errori. Ricorda di controllare accuratamente la tua analisi prima di utilizzarla.';

      // Carica il template di base (assicurati di avere un template.docx nel progetto)
      final ByteData data = await rootBundle.load(r'assets/docs/template.docx');
      final bytes = data.buffer.asUint8List();
      final docx = await docxTemp.DocxTemplate.fromBytes(bytes);

      // Definisci i contenuti da inserire nel template
      final docxTemp.Content content = docxTemp.Content();
      content.add(docxTemp.TextContent("risposta", response4!));
      // content.add(docxTemp.TableContent("table", [

      //   docxTemp.RowContent()
      // ]));

      // Genera il documento
      final generatedDocx = await docx.generate(content);

      if (generatedDocx == null) {
        throw UnsupportedError('Errore nella generazione del documento');
      }

      // Salva il file generato
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/documento.docx';
      await File(path).writeAsBytes(generatedDocx);

      // Apri il file con l'app predefinita
      Future.delayed(Duration(milliseconds: 900), () async {
        await OpenFile.open(path);
      });

      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Versione generata con successo e salvata correttamente. ParaLat AI potrebbe commettere errori. Considera di verificare le informazioni più importanti."
        });
        _isLoading = false;
      });
    } on TimeoutException {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text": "Errore: ParaLat AI ha impiegato troppo tempo a rispondere."
        });
        _isLoading = false;
      });
    } on PathNotFoundException {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Errore: ParaLat AI ha riscontrato un problema nel salvataggio del file. Prova a svuotare le cache e verifica di aver concesso tutte le autorizzazioni necessarie. Se non dovessi risolvere contatta lo sviluppatore tramite la mail: lorenzodellabona06@gmail.com"
        });
        _isLoading = false;
      });
    } on FileSystemException {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Errore: ParaLat AI non è riuscito a salvare il file. Verifica di avere spazio sufficiente sul dispositivo e di aver concesso tutti i permessi necessari."
        });
        _isLoading = false;
      });
    } on ClientException {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Errore: Impossibile raggiungere i server di ParaLat AI. Verifica la stabilità della tua connessione ad internet."
        });
        _isLoading = false;
      });
    } on GenerativeAIException catch (e) {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Errore: A causa di contenuti potenzialmente inappropriati ParaLat AI Safety system ha bloccato la risposta alla tua domanda ${e.toString()}"
        });
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        print(e.toString());
        print(e.runtimeType.toString());
        _messages.add({
          "sender": "bot",
          "text":
              "Errore: ParaLat AI ha riscontrato un errore sconosciuto durante il processo della tua richiesta. Riprova più tardi"
        });
        _isLoading = false;
      });
    }
  }

  Widget _buildMessage(Map<String, String> message) {
    bool isUserMessage = message["sender"] == "user";
    return Align(
      alignment: isUserMessage ? Alignment.centerLeft : Alignment.centerRight,
      child: SizedBox(
        width: 300,
        child: Card(
          color: isUserMessage ? Colors.blue[100] : Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Allinea gli elementi all'inizio
            children: [
              Padding(
                padding:
                    const EdgeInsets.all(8), // Distanza tra l'icona e il testo
                child: isUserMessage
                    ? Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      )
                    : Icon(
                        Icons.generating_tokens,
                        color: Colors.deepPurple,
                      ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8, right: 8),
                      child: Text(
                        isUserMessage ? 'User' : 'ParaLat AI',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    SizedBox(
                        height: 2), // Distanza tra il titolo e il sottotitolo
                    Text(
                      message["text"] ?? "",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatta con ParaLat AI'),
        toolbarHeight: 130,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse:
                  true, // Scorri automaticamente verso il basso quando vengono aggiunti nuovi messaggi
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _messages
                    .map((message) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: _buildMessage(message),
                        ))
                    .toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    child: TextField(
                      controller: _controller,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        labelText: 'Inserisci la tua versione',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.camera_alt_outlined),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_controller.text.isNotEmpty) {
                            _fetchResponse(_controller.text);
                            _controller.clear();
                          }
                        },
                        child: const Icon(Icons.send),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
