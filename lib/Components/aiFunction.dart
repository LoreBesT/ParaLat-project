import 'package:google_generative_ai/google_generative_ai.dart';


const String apiKey = 'AIzaSyA8XweciTZnjycM2iwHRSzCle-3YAYzV2o';

Future<String> aiFunction(
  String contextText,
  String author,
) async {
  final String prompt =
      'Genera un breve riassunto del seguente articolo: "$contextText".\n Tieni presente infine che l\'articolo è stato scritto da $author. Fornisci il riassunto come una semplice stringa. Non fare alcuna premessa fornisci il riassunto direttamente';
  final model = GenerativeModel(model: "gemini-2.0-flash-lite", apiKey: apiKey);
  try {
    final response = await model.generateContent([Content.text(prompt)]);
    return response.text!;
  } catch (e) {
    return 'Errore: Impossibile generare un riassunto.';
  }
}