// import 'dart:async';
// import 'dart:io';

// import 'package:docx_template/docx_template.dart' as docxTemp;
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:http/http.dart';
// import 'package:open_file/open_file.dart';
// import 'package:path_provider/path_provider.dart';
// // Usare docx_template
// // Opzione 2: creare un file base salvato su firestore modificarlo ad ogni richiesta e scaricarlo con dio come in archivio

// class GeminiApiPage extends StatefulWidget {
//   @override
//   _GeminiApiPageState createState() => _GeminiApiPageState();
// }

// class _GeminiApiPageState extends State<GeminiApiPage> {
//   final TextEditingController _controller = TextEditingController();
//   List<Map<String, String>> _messages =
//       []; // Cambia a lista di mappe per tracciare chi ha inviato il messaggio
//   final String apiKey = 'AIzaSyA8XweciTZnjycM2iwHRSzCle-3YAYzV2o';
//   bool _isLoading = false;
//   final ScrollController _scrollController = ScrollController();

//   Future<void> _fetchResponse(String text) async {
//     final model = GenerativeModel(model: "gemini-1.5-flash", apiKey: apiKey);
//     final completeInput =
//         'Ciao ho questa versione. Creami una tabella in cui nella prima colonna metti la parola latina, nella seconda metti il complemento per i nomi, il modo per i verbi e la parte del discorso per i restanti. Nella terza colonna metti il caso per nomi, pronomi e aggettivi e il tempo per i verbi. Nella quarta metti il genere(per i verbi metti la persona 1,2,3). Nella quinta metti il genere(per i verbi il numero). Nella sesta metti il paradigma/derivazione ed infine nella settima la corrispettiva traduzione di ogni parola. N.B per parole che non hanno tutte le proprietà precedentemente descritte come una conginzione metti una \'/\' nelle caselle da non completare. Questa è la versione da analizzare: $text';
//     setState(() {
//       _messages.add({"sender": "user", "text": text});
//       _isLoading = true;
//     });

//     try {
//       final response = await model.generateContent([
//         Content.text(completeInput),
//       ]);
//       String? response2 = response.text?.replaceAll("*", "");
//       final directory = await getTemporaryDirectory();
//       final path = '${directory.path}/documento.txt';
//       await File(path).writeAsString(
//         response2!,
//         mode: FileMode.write,
//       );

//       // Apri il file con l'app predefinita
//       Future.delayed(Duration(seconds: 2), () async {
//         await OpenFile.open(path);
//       });

//       setState(() {
//         _messages.add({
//           "sender": "bot",
//           "text": /*response2!*/
//               "Versione generata con successo e salvata correttamente. ParaLat AI potrebbe commettere errori. Considera di verificare le informazioni più importanti."
//         }); // Supponendo che la risposta abbia una proprietà 'text'
//         _isLoading = false;
//       });
//     } on TimeoutException {
//       setState(() {
//         _messages.add({
//           "sender": "bot",
//           "text": "Errore: ParaLat AI ha impiegato troppo tempo a rispondere."
//         });
//         _isLoading = false;
//       });
//     } on PathNotFoundException {
//       setState(() {
//         _messages.add({
//           "sender": "bot",
//           "text":
//               "Errore: ParaLat AI ha riscontrato un problema nel salvataggio del file. Prova a svuotare le cache e verifica di aver concesso tutte le autorizzazioni necessarie. Se non dovessi risolvere contatta lo sviluppatore tramite la mail: lorenzodellabona06@gmail.com"
//         });
//         _isLoading = false;
//       });
//     } on FileSystemException {
//       setState(() {
//         _messages.add({
//           "sender": "bot",
//           "text":
//               "Errore: ParaLat AI non è riuscito a salvare il file. Verifica di avere spazio sufficiente sul dispositivo e di aver concesso tutti i permessi necessari."
//         });
//         _isLoading = false;
//       });
//     } on ClientException {
//       setState(() {
//         _messages.add({"sender": "bot", "text": "Errore: Impossibile raggiungere i server di ParaLat AI. Verifica la stabilità della tua connessione ad internet."});
//         _isLoading = false;
//       });
//     } on GenerativeAIException {
//       setState(() {
//         _messages.add({"sender": "bot", "text": "Errore: A causa di contenuti potenzialmente inappropriati ParaLat AI Safety system ha bloccato la risposta alla tua domanda"});
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         print(e.toString());
//         print(e.runtimeType.toString());
//         _messages.add({
//           "sender": "bot",
//           "text":
//               "Errore: ParaLat AI ha riscontrato un errore sconosciuto durante il processo della tua richiesta. Riprova più tardi"
//         });
//         _isLoading = false;
//       });
//     }
//   }

//   Widget _buildMessage(Map<String, String> message) {
//     bool isUserMessage = message["sender"] == "user";
//     return Align(
//       alignment: isUserMessage ? Alignment.centerLeft : Alignment.centerRight,
//       child: SizedBox(
//         width: 300,
//         child: Card(
//           color: isUserMessage ? Colors.blue[100] : Colors.grey[300],
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             crossAxisAlignment:
//                 CrossAxisAlignment.start, // Allinea gli elementi all'inizio
//             children: [
//               Padding(
//                 padding:
//                     const EdgeInsets.all(8), // Distanza tra l'icona e il testo
//                 child: isUserMessage
//                     ? Icon(Icons.person)
//                     : Icon(Icons.generating_tokens),
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 8, right: 8),
//                       child: Text(
//                         isUserMessage ? 'User' : 'ParaLat AI',
//                         textAlign: TextAlign.left,
//                         style: TextStyle(
//                             fontSize: 14, fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                     SizedBox(
//                         height: 2), // Distanza tra il titolo e il sottotitolo
//                     Text(
//                       message["text"] ?? "",
//                       style: TextStyle(fontSize: 16),
//                       textAlign: TextAlign.left,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           // child: //Padding(
//           //   padding: const EdgeInsets.all(8.0),
//           //   child: Text(
//           //     message["text"] ?? "",
//           //     style: const TextStyle(fontSize: 16),
//           //   ),
//           // ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chatta con ParaLat AI'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               reverse:
//                   true, // Scorri automaticamente verso il basso quando vengono aggiunti nuovi messaggi
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: _messages
//                     .map((message) => Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 4.0),
//                           child: _buildMessage(message),
//                         ))
//                     .toList(),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(100)),
//                     child: TextField(
//                       controller: _controller,
//                       autocorrect: false,
//                       decoration: const InputDecoration(
//                         labelText: 'Inserisci la tua versione',
//                         border: OutlineInputBorder(),
//                         suffixIcon: Icon(Icons.camera_alt_outlined),
//                         enabledBorder: InputBorder.none,
//                         focusedBorder: InputBorder.none,
//                         contentPadding: EdgeInsets.only(left: 10),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 _isLoading
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: () {
//                           FocusScope.of(context).unfocus();
//                           if (_controller.text.isNotEmpty) {
//                             _fetchResponse(_controller.text);
//                             _controller.clear();
//                           }
//                         },
//                         child: const Icon(Icons.send),
//                       ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
