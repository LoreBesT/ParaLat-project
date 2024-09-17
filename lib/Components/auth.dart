import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:paralat/Components/level_user.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:battery_plus/battery_plus.dart';
// import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<List<DocumentSnapshot>> searchInFirestore(String searchString) async {
  final collectionRef = FirebaseFirestore.instance.collection('Versioni');
  final querySnapshot = await collectionRef.get();
  final matchingDocs = querySnapshot.docs.where((doc) {
    final body = doc['versione'] as String?;
    return body != null && body.contains(searchString);
  }).toList();
  return matchingDocs;
}

  Future<void> downloadFile(String url, String fileName, BuildContext context) async {
    final Directory? appDocDir = await getExternalStorageDirectory();
    final String filePath = '${appDocDir!.path}/$fileName';

    try {
      // print('Tentativo di scaricare il file $fileName da $url');
      Dio dio = Dio();
      await dio.download(url, filePath);
      // print('File scaricato con successo in $filePath');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('File scaricato: $fileName')));
      OpenFile.open(filePath); // Apre il file appena scaricato
    } catch (e) {
      // print('Errore durante il download del file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Errore durante il download: $e')));
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createReport(String title, String description, String userId,
      BuildContext context) async {
    CollectionReference reports =
        FirebaseFirestore.instance.collection('reports');
    return reports
        .add({
          'title': title,
          'description': description,
          'userId': userId,
          'timestamp': FieldValue.serverTimestamp(),
          'piattaforma':
              '${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
          'processori': Platform.numberOfProcessors.toString(),
          'lingua e regione': Platform.localeName,
        })
        .then((value) {})
        .catchError((error) {});
  }

  Future<void> createEvent(
      String title, String? body, String color, DateTime scadenza) async {
    CollectionReference reports =
        FirebaseFirestore.instance.collection('scadenze');
    return reports
        .add({
          'title': title,
          'body': body,
          'imp': color,
          'scadenza': scadenza,
          'adder': Verify().nameUser(4)
        })
        .then((value) {})
        .catchError((error) {});
  }

  Future<void> uploadVersione(
      String title, String versione, String autore, String traduzione) async {
    CollectionReference versioni =
        FirebaseFirestore.instance.collection('Versioni');
    return versioni
        .add({
          'title': title,
          'versione': versione,
          'autore': autore,
          'traduzione': traduzione,
          'data/ora': FieldValue.serverTimestamp(),
          'caricatore': Verify().nameUser(4)
        })
        .then((value) {})
        .catchError((error) {
          print(error);
        });
  }

  Future<void> createNews(String nome, String uid) async {
    String title = 'Ciao $nome, benvenuto su ParaLat!';
    String body =
        'Ciao $nome e benvenuto su ParaLat. Siamo lieti di accoglierti all\'interno della nostra community.\nTi informarmiamo che avrai a disposizione molteplici funzionalità totalmente gratuite e senza limite. Qualora avessi bisogno di ulteriori strumenti potrai abbonarti a ParaLat Premium in forma mensile o annuale\nIn caso di problemi con ParaLat siamo sempre a tua disposizione.\n\nUn saluto, il tuo ParaLat Team';
    CollectionReference reports = FirebaseFirestore.instance.collection('news');
    return reports
        .add({
          'title': title,
          'body': body,
          'imp': 'purple',
          'ora': FieldValue.serverTimestamp(),
          'to': uid
        })
        .then((value) {})
        .catchError((error) {});
  }

  Future<void> deleteDocument(DocumentSnapshot documentSnapshot) async {
    try {
      // Ottieni la referenza del documento dal DocumentSnapshot
      final documentRef = documentSnapshot.reference;
      await documentRef.delete();
    } catch (e) {}
  }

  Future<void> setNameAndSurname(
      {required String name, required String surname}) async {
    try {
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.updateDisplayName('$name $surname');
        await user.reload();
        user = _firebaseAuth.currentUser; // Refresh user instance
      }
    } catch (e) {
      // Handle error, e.g., print to console or show a message to the user
    }
  }

  String? getUserDisplayName() {
    String? nome = _firebaseAuth.currentUser?.displayName;
    if (nome != null) {
      return _firebaseAuth.currentUser?.displayName;
    } else {
      return '';
    }
  }

  String? getUID() {
    User? utente = _firebaseAuth.currentUser;
    return utente!.uid.toString();
  }

  Future<void> signOut(context) async {
    try {
      await _firebaseAuth.currentUser?.reload();
      await _firebaseAuth.signOut();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Errore: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> reimpostaPassword(context, bool isInAuth,
      [String email = 'email']) async {
    if (isInAuth == false) {
      try {
        User? utente = _firebaseAuth.currentUser;
        await _firebaseAuth.sendPasswordResetEmail(
            email: utente!.email.toString());
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Errore nell\'invio della mail di password reset\nCodice errore ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Errore nell\'invio della mail di password reset\nCodice errore ${e.message}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> deleteAccount(context) async {
    try {
      User? utente = _firebaseAuth.currentUser;
      utente?.delete();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Errore nell\'eliminazione dell\'account\nCodice errore ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  bool isDarkTheme(BuildContext context) {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  String? metaDatas(BuildContext context, int i) {
    try {
      User? utente = _firebaseAuth.currentUser;
      int numero = utente!.metadata.creationTime!.minute.toInt();
      int numeroLastSignIn = utente.metadata.lastSignInTime!.minute.toInt();
      String numeroLastSignIn2 = numeroLastSignIn.toString();
      String numero2 = numero.toString();
      if (numero < 10) {
        numero2 = '0$numero2';
      }
      if (numeroLastSignIn < 10) {
        numeroLastSignIn2 = '0$numeroLastSignIn2';
      }

      String? creationTime =
          '${utente.metadata.creationTime?.day.toString()}/${utente.metadata.creationTime?.month.toString()}/${utente.metadata.creationTime?.year.toString()} ${utente.metadata.creationTime?.hour.toString()}:$numero2';
      String? lastSignIn =
          '${utente.metadata.lastSignInTime?.day.toString()}/${utente.metadata.lastSignInTime?.month.toString()}/${utente.metadata.lastSignInTime?.year.toString()} ${utente.metadata.lastSignInTime?.hour.toString()}:$numeroLastSignIn2';
      switch (i) {
        case 0:
          return creationTime;
        case 1:
          return lastSignIn;
        case 2:
          return utente.email.toString();
        case 3:
          return utente.uid.toString();
        case 4:
          return utente.providerData.toString();
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Errore nell\'invio della mail di password reset\nCodice errore ${e.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return null;
  }
}
