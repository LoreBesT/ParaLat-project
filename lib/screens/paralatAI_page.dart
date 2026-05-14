import 'dart:async';
import 'dart:io';
import 'package:cleartec_docx_template/cleartec_docx_template.dart' as docxTemp;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart';
import 'package:open_file/open_file.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/drawer_buttons/drawerSwitchButton.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:paralat/Components/navfloatbar.dart';
import 'package:paralat/Components/rounded_buttons_new.dart';
import 'package:paralat/Components/tipsChat.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GeminiApiPage extends StatefulWidget {
  const GeminiApiPage({super.key});

  @override
  _GeminiApiPageState createState() => _GeminiApiPageState();
}

class _GeminiApiPageState extends State<GeminiApiPage> {
  final int _index = 0;
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages =
      []; // Cambia a lista di mappe per tracciare chi ha inviato il messaggio
  String? apiKey;
  String? models;
  String? input;
  bool isMessage = false;
  @override
  void initState() {
    super.initState();
    _initApiKey();
    _initModels();
    _initInput();
  }

  Future<void> _initApiKey() async {
    try {
      // Recupera la chiave API dal documento
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('apiKey')
          .get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          apiKey = doc['value'];
        });
        // print("✅✅✅Chiave API caricata correttamente.");
      } else {
        throw Exception('Chiave API non trovata su Firestore');
      }
    } catch (e) {
      // print("❤️❤️❤️Errore nel recupero della chiave API: $e");
      setState(() {
        _messages.add(
            {"sender": "bot", "text": "Errore nel recupero della chiave API."});
      });
    }
  }

  Future<void> _initModels() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('model')
          .get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          models = doc['value'];
        });
        // print("✅✅✅Chiave API caricata correttamente.");
      } else {
        throw Exception(
            'Errore nell\'inizializzazione del modello AI. Riprova più tardi.');
      }
    } catch (e) {
      // print("❤️❤️❤️Errore nel recupero della chiave API: $e");
      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Errore nell'inizializzazione del modello AI. Riprova più tardi."
        });
      });
    }
  }

  Future<void> _initInput() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('config')
          .doc('input')
          .get();

      if (doc.exists && doc.data() != null) {
        setState(() {
          input = doc['value'];
        });
        // print("✅✅✅Chiave API caricata correttamente.");
      } else {
        throw Exception('Errore nella connessione al server');
      }
    } catch (e) {
      // print("❤️❤️❤️Errore nel recupero della chiave API: $e");
      setState(() {
        _messages.add(
            {"sender": "bot", "text": "Errore nella connessione al server"});
      });
    }
  }

  bool _isLoading = false;
  bool _isPickingImage = false;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  // String models = '2.5-flash';
  bool aiProActive = false;

  Future<void> _pickImage(ImageSource source) async {
    if (_isPickingImage) return;
    _isPickingImage = true;

    try {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        setState(() {
          // _controller.text == 'Analizza';
          _selectedImage = File(image.path); // Salva l'immagine
          _messages.add({
            "sender": "user",
            "text": "📷 Immagine selezionata: ${image.name}"
          });
          FocusScope.of(context).unfocus();
          _fetchResponse(_controller.text);
          _controller.clear();
        });
      }
    } finally {
      _isPickingImage = false;
    }
  }

  Future<void> _fetchResponse(String text) async {
    if (apiKey == null) {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text": "Errore: chiave API non disponibile. Riprova più tardi."
        });
        _isLoading = false;
      });
      return;
    }
    final model = GenerativeModel(model: "gemini-$models", apiKey: apiKey!);
    //final completeInput =
    //'Ciao ho questa versione che devi analizzare secondo le indicazioni che ti do. L\'analisi la incollerò in un file word, perciò dedica una riga per l\'analisi di ciascuna parola. L\'analisi dovrà essere svolta così: subito dopo la parola metti il complemento(oggetto, specificazione, termine, stato in luogo, soggetto ecc... ecc..) per nomi, e pronomi e aggettivi(per gli aggettivi specifica scrivendo ad esempio: Att. del compl di termine); per i verbi metti il modo(indicativo, congiuntivo ecc.. ecc..) per il resto metti invece la parte del discorso(congiunzione, interazione, avverbio ecc...). Dopo tale parte metti il caso per nomi, pronomi e aggettivi ed il tempo per i verbi. In seguito metti il genere(Indica il maschile con M ed il femminile con F) mentre per i verbi metti la persona(Indicandola con 1, 2, 3). Dopo metti il numero(indicandolo con S per il singolare e P per il plurale). Dopo metti per i verbi il paradigma del verbo(Ricorda il paradigma è costituito da 5 voci del verbo: 1 persona indicativo presente, 2 persona indicativo presente, 1 persona indicativo perfetto, supino, infinito presente) mentre per il resto la derivazione(nominativo e genitivo singolare della parola in questione). Infine metti  la corrispettiva traduzione italiana di ogni parola. Un ultima precisazione non fornirmi l\'output in markdown e fornisci l\'analisi completa NON DEVI BLOCCARTI A META\' ANALISI. PRIMA DI PROCEDERE ALL\'ANALISI LOGICA VOGLIO CHE MI FORNISCI LA TRADUZIONE COMPLESSIVA DELLA VERSIONE SCRIVERNDO PRIMA " Traduzione:" ed incollandola di seguito. Poi staccati di uno spazio ed incolla l\'analisi preceduta da una scritta "Analisi della versione:". N.B. Se qualcuna delle precedenti voci dovesse risultare vuota allora non metti direttamente la voce successiva. Questo è un esempio di come fare l\'analisi: Vocas = indicativo, presente 2 S, voco-vocas-vocavi-vocatum-vocare trad: chiami. Oppure per una congiunzione: et = congiunzione trad: e. Per un nome invece ad esempio: rosam = Compl. Oggetto, accusativo, F, S, rosa-rosae, trad: la rosa. Questa è la versione da analizzare: $text';
    final completeInput = '$input $text';
    setState(() {
      _messages.add({"sender": "user", "text": text});
      _isLoading = true;
    });

    try {
      final List<Content> contents = [];

      // Aggiungi immagine se presente
      if (_selectedImage != null) {
        final bytes = await _selectedImage!.readAsBytes();
        contents.add(
          Content.multi([
            TextPart(completeInput),
            DataPart('image/jpg', bytes), // o 'image/png' se PNG
          ]),
        );
      } else {
        contents.add(Content.text(completeInput));
      }

      final response = await model.generateContent(contents);

      String response2 = response.text ?? "";
      String response3 = response2.replaceAll("*", "").replaceAll("#", "");
      String response4 =
          '$response3\n\nVersione generata con ParaLat AI\nParaLat AI può commettere errori. Ricorda di controllare accuratamente la tua analisi prima di utilizzarla.';

      // Carica il template DOCX
      final ByteData data = await rootBundle.load(r'assets/docs/template.docx');
      final bytes = data.buffer.asUint8List();
      final docx = await docxTemp.DocxTemplate.fromBytes(bytes);

      final docxTemp.Content content = docxTemp.Content();
      content.add(docxTemp.TextContent("risposta", response4));

      final generatedDocx = await docx.generate(content);

      if (generatedDocx == null) {
        throw UnsupportedError('Errore nella generazione del documento');
      }

      // Salva e apri
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${directory.path}/documento_$timestamp.docx';
      await File(path).writeAsBytes(generatedDocx);

      Future.delayed(const Duration(milliseconds: 900), () async {
        await OpenFile.open(path);
      });

      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Versione generata con successo e salvata correttamente. ParaLat AI potrebbe commettere errori. Considera di verificare le informazioni più importanti."
        });
        _isLoading = false;
        _selectedImage = null; // Reset immagine dopo invio
      });
    } on TimeoutException {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Errore: ParaLat AI ha impiegato troppo tempo a rispondere. Riprova più tardi"
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
              "Errore nell'accesso ai modelli di ParaLat AI. Riprova più tardi. ${e.toString()}"
        });
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add({
          "sender": "bot",
          "text":
              "Errore: ParaLat AI ha riscontrato un errore sconosciuto durante il processo della tua richiesta. Riprova più tardi. ${e.toString()}"
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
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.circularBorder,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppRadius.circularBorder,
              gradient: isUserMessage
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 167, 98, 242),
                        Color.fromARGB(255, 191, 85, 226),
                        Color.fromARGB(255, 214, 77, 196),
                      ],
                      stops: [0.0, 0.45, 1.0],
                    )
                  : LinearGradient(
                      colors: [
                        // Colors.grey.shade100,
                        // Colors.grey.shade200,
                        const Color(0xFFF5F7FA),
                        const Color(0xFFE8EDF3),
                      ],
                    ),
              boxShadow: isUserMessage
                  ? [
                      const BoxShadow(
                        color: Color.fromARGB(40, 180, 80, 220),
                        blurRadius: 18,
                        offset: Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: isUserMessage
                        ? const Icon(
                            Icons.person,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.generating_tokens,
                            color: Colors.black,
                          ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isUserMessage ? 'Tu' : 'ParaLat AI',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isUserMessage ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          message["text"] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            color: isUserMessage ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? funzioni = Verify().funzioniBottAppBar(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logoApp.png',
              scale: 9,
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('ParaLat AI'),
                Text(
                  "Analisi logica latina",
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        // centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: isMessage
                    ? true
                    : false, // Scorri automaticamente verso il basso quando vengono aggiunti nuovi messaggi
                padding: const EdgeInsets.only(
                    top: 26, bottom: 26, left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!isMessage)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Traduci e analizza",
                            style: TextStyle(
                                fontSize: 30,
                                color: AppColors.text,
                                fontWeight: FontWeight.w600),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "il ",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "latino ",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: AppColors.gradientStart,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "con l'AI",
                                style: TextStyle(
                                    fontSize: 30,
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                              "Incolla la tua versione latina ed ottieni traduzione ed analisi logica in pochi secondi.",
                              style: TextStyle(color: Colors.black87)),
                          SizedBox(
                            height: 12,
                          ),
                          Tip(
                              icon: Icons.translate,
                              title: "Traduzione accurata",
                              subtitle: "Traduzioni fedeli e contestualizzate"),
                          SizedBox(
                            height: 10,
                          ),
                          Tip(
                              icon: Icons.account_tree,
                              title: "Analisi logica completa",
                              subtitle:
                                  "Analisi logico grammaticale dettagliata di ogni parola"),
                          SizedBox(
                            height: 10,
                          ),
                          Tip(
                              icon: Icons.bolt,
                              title: "Risultati istantanei",
                              subtitle:
                                  "Risposte rapide e chiare sempre a portata di mano"),
                        ],
                      ),
                    /*inserire qui widget temporanei */
                    ..._messages.map((message) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: _buildMessage(message),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 23,
                    child: IconButton(
                      icon: const Icon(
                          Icons.image), // Si può sostituire con icons.add
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return SafeArea(
                              child: Padding(
                                padding: const EdgeInsetsGeometry.all(14),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        RoundedButtonsNew(
                                            testo: 'Fotocamera',
                                            icon: Icons.camera_alt,
                                            function: () {
                                              Navigator.pop(context);
                                              _pickImage(ImageSource.camera);
                                            },
                                            page: false),
                                        RoundedButtonsNew(
                                            testo: 'Foto',
                                            icon: Icons.image_sharp,
                                            function: () {
                                              Navigator.pop(context);
                                              _pickImage(ImageSource.gallery);
                                            },
                                            page: false),
                                      ],
                                    ),
                                    // const Divider(),
                                    // ButtonNoAnimatedTr(testo: 'PDF'),
                                    // ButtonNoAnimatedTr(testo: 'DOC'),
                                    // const Divider(),
                                    // const ButtonNoAnimatedTr(
                                    //   icona: Icons.diamond_outlined,
                                    //   testo: 'AI PRO',
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        // setState(() {
                        //   _messages.clear(); // Pulisce la chat
                        // });
                      },
                    ),
                  ),
                  Expanded(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: AppRadius.circularBorder,
                      ),
                      child: TextField(
                        controller: _controller,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Incolla qui la tua versione',
                          // hint: ,
                          border: const OutlineInputBorder(),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.only(left: 10),
                          suffixIcon: _isLoading
                              ? const CircularProgressIndicator()
                              : IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    setState(() {
                                      isMessage = true;
                                    });
                                    if (_controller.text.isNotEmpty) {
                                      _fetchResponse(_controller.text);
                                      _controller
                                          .clear(); // Pulisci il campo di testo dopo aver inviato il messaggio
                                    }
                                  },
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavFloatBar(
        index: _index,
        funzioni: funzioni,
      ),
    );
  }
}
