import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Questo è un esempio, sostituisci con la libreria corretta se differente

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
        title: const Text('Contact Center'),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Descrivi il tuo problema',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                              String completeInput = 'Ciao quest\'app android non sta funzionando bene. Il problema riscontranto è il seguente: ${_controller.text}. Come posso risolvere?';
                            _fetchResponse(completeInput);
                            _controller
                                .clear(); // Pulisci il campo di testo dopo aver inviato il messaggio
                          }
                        },
                        child: const Text('Invia'),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
