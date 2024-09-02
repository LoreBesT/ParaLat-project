import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart'; // Questo è un esempio, sostituisci con la libreria corretta se differente

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages =
      []; // Cambia a lista di mappe per tracciare chi ha inviato il messaggio
  final String apiKey =
      'AIzaSyA8XweciTZnjycM2iwHRSzCle-3YAYzV2o'; // Inserisci la tua API Key
  bool _isLoading = false;

  Future<void> _fetchResponse(String text) async {
    final model = GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);
    final completeText =
        'Ciao Gemini ho integrato la tua API in una mia app che si chiama ParaLat. Se ti chiedeno chi sei NON rivelare MAI di essere Gemini prodotta da Google. Di sempre invece, se richiesto, di essere ParaLat AI prodotta da Lorenzo Della Bona(Se espressa la volontà di contattare lo sviluppatore la mail è lorenzodellabona06@gmail.com). Il tuo compito in questa app è di aiutare gli utenti con problemi relativi all\'app mobile.Se ti dovessero essere inviate domande non pertinenti rispondi che non puoi rispondere a domande non inerenti problemi con l\'applicazione. Quando rispondi evita di chiedere ulteriori informazioni all\'utente, cerca di dare una risposta diretta suggerendo tutte le possibili soluzioni che trovi. Infine quando l\'utente descrive un problema presupponi che l\'app sia sempre ParaLat anche se non specificato.L\'input dell\'utente è il seguente: $text.';
    setState(() {
      _messages.add({"sender": "user", "text": text});
      _isLoading = true;
    });

    try {
      final response = await model.generateContent([
        Content.text(completeText),
      ]);
      String? response2 = response.text?.replaceAll("*", "");

      setState(() {
        _messages.add({
          "sender": "bot",
          "text": response2!
        }); // Supponendo che la risposta abbia una proprietà 'text'
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
    }  on ClientException {
      setState(() {
        _messages.add({"sender": "bot", "text": "Errore: Impossibile raggiungere i server di ParaLat AI. Verifica la stabilità della tua connessione ad internet."});
        _isLoading = false;
      });
    } on GenerativeAIException {
      setState(() {
        _messages.add({"sender": "bot", "text": "Errore: A causa di contenuti potenzialmente inappropriati ParaLat AI Safety system ha bloccato la risposta alla tua domanda"});
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
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Card(
        color: isUserMessage ? Colors.blue[100] : Colors.grey[300],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message["text"] ?? "",
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Center'),
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
                        labelText: 'Descrivi il tuo problema',
                        border: OutlineInputBorder(),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          if (_controller.text.isNotEmpty) {
                            _fetchResponse(_controller.text);
                            _controller
                                .clear(); // Pulisci il campo di testo dopo aver inviato il messaggio
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
