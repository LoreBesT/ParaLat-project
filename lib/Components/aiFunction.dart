import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> aiFunction(
  String contextText,
  String author,
) async {
  // Recupera la chiave API da Firestore
  String? apiKey;
  try {
    final doc = await FirebaseFirestore.instance
        .collection('config')
        .doc('apiKey')
        .get();

    if (doc.exists && doc.data() != null) {
      apiKey = doc['value'];
    } else {
      return 'Errore: Chiave API non trovata.';
    }
  } catch (e) {
    return 'Errore nel recupero della chiave API: $e';
  }

  // Costruisci il prompt
  final String prompt =
      'Genera un breve riassunto del seguente articolo: "$contextText".\n Tieni presente infine che l\'articolo è stato scritto da $author. Fornisci il riassunto come una semplice stringa. Non fare alcuna premessa fornisci il riassunto direttamente';

  // Controlla che la chiave sia presente
  if (apiKey == null) {
    return 'Errore: chiave API non disponibile.';
  }

  final model = GenerativeModel(
    model: "gemini-2.0-flash-lite",
    apiKey: apiKey,
  );

  try {
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text ?? 'Errore: Risposta vuota.';
  } catch (e) {
    return 'Errore: Impossibile generare un riassunto.';
  }
}
