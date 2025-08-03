import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openIg(String username) async {
  final nativeUrl = Uri.parse('instagram://user?username=$username');
  final webUrl = Uri.parse('https://www.instagram.com/$username/');

  // Prova ad aprire l'app Instagram, se installata
  if (await canLaunchUrl(nativeUrl)) {
    await launchUrl(nativeUrl);
  } else {
    // Altrimenti apri nel browser
    await launchUrl(webUrl, mode: LaunchMode.externalApplication);
  }
}

Future<void> openTikTok(String username) async {
  final nativeUrl = Uri.parse('tiktok://user/@$username');
  final webUrl = Uri.parse('https://www.tiktok.com/@$username');

  // Prova ad aprire l'app TikTok, se installata
  if (await canLaunchUrl(nativeUrl)) {
    await launchUrl(nativeUrl);
  } else {
    // Altrimenti apri nel browser
    await launchUrl(webUrl, mode: LaunchMode.externalApplication);
  }
}

Future<void> openYt(String ID) async {
  final nativeUrl = Uri.parse('vnd.youtube://channel/$ID');
  final webUrl = Uri.parse('https://www.youtube.com/channel/$ID/');

  // Prova ad aprire l'app Instagram, se installata
  if (await canLaunchUrl(nativeUrl)) {
    await launchUrl(nativeUrl);
  } else {
    // Altrimenti apri nel browser
    await launchUrl(webUrl, mode: LaunchMode.externalApplication);
  }
}

Future<void> openTg(String username) async {
  final nativeUrl = Uri.parse('tg://resolve?domain=$username');
  final webUrl = Uri.parse('https://t.me/$username');

  // Prova ad aprire l'app Instagram, se installata
  if (await canLaunchUrl(nativeUrl)) {
    await launchUrl(nativeUrl);
  } else {
    // Altrimenti apri nel browser
    await launchUrl(webUrl, mode: LaunchMode.externalApplication);
  }
}

Future sendMail(BuildContext context, String email, String titolo, String body) async {
  final String subject = Uri.encodeComponent(titolo);
  final String encodedBody = Uri.encodeComponent(body);

  final Uri emailUri = Uri.parse('mailto:$email?subject=$subject&body=$encodedBody');

 try {
    await launchUrl(emailUri);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Impossibile aprire il client email.'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> openSite(BuildContext context, String sito) async {
  final webUrl = Uri.parse(sito);
  try {
    final launched =
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
    if (!launched) {
      throw Exception('Impossibile aprire il sito');
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Errore: impossibile aprire il sito."),
        backgroundColor: Colors.red,
      ),
    );
  }
}
