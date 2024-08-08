import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiApiPage extends StatefulWidget {
  @override
  _GeminiApiPageState createState() => _GeminiApiPageState();
}

class _GeminiApiPageState extends State<GeminiApiPage> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages =
      []; // Cambia a lista di mappe per tracciare chi ha inviato il messaggio
  final String apiKey = 'AIzaSyA8XweciTZnjycM2iwHRSzCle-3YAYzV2o';
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  Future<void> _fetchResponse(String text) async {
    final model = GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);
    setState(() {
      _messages.add({"sender": "user", "text": text});
      _isLoading = true;
    });

    try {
      final response = await model.generateContent([
        Content.text(text),
      ]);
      String? response2 = response.text?.replaceAll("*", "");
      setState(() {
        _messages.add({
          "sender": "bot",
          "text": response2!
        }); // Supponendo che la risposta abbia una proprietà 'text'
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.add({"sender": "bot", "text": "Error: $e"});
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
        title: const Text('Chatta con ParaLat AI'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              // reverse:
              //     true, // Scorri automaticamente verso il basso quando vengono aggiunti nuovi messaggi
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
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
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
                          if (_controller.text.isNotEmpty) {
                            String completeInput =
                                'Ciao ho questa versione. Creami una tabella in cui nella prima colonna metti la parola latina, nella seconda metti il complemento per i nomi, il modo per i verbi e la parte del discorso per i restanti. Nella terza colonna metti il caso per nomi, pronomi e aggettivi e il tempo per i verbi. Nella quarta metti il genere(per i verbi metti la persona 1,2,3). Nella quinta metti il genere(per i verbi il numero). Nella sesta metti il paradigma/derivazione ed infine nella settima la corrispettiva traduzione di ogni parola. N.B per parole che non hanno tutte le proprietà precedentemente descritte come una conginzione metti una \'/\' nelle caselle da non completare. Questa è la versione da analizzare: ${_controller.text}';
                            _fetchResponse(completeInput);
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
