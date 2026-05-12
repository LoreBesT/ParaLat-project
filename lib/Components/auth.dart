import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:paralat/Components/custom_snackbar.dart';
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

  Future<void> downloadFile(
      String url, String fileName, BuildContext context) async {
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
        customSnackBar("Errore durante il download: $e!",
            type: SnackBarType.error),
      );
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'toRead': 0,
    });
  }

  Future<void> creaProfiloSeNonEsiste(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'toRead': 0,
    });
  }

  Future<void> incrementaCounter(String uid, bool isIncrement) async {
    const int maxAttempts = 10;
    int attempts = 0;

    while (attempts < maxAttempts) {
      try {
        final docRef = FirebaseFirestore.instance.collection('users').doc(uid);

        await docRef.update({
          'toRead':
              isIncrement ? FieldValue.increment(1) : FieldValue.increment(-1),
        });

        // se va a buon fine esci
        return;
      } catch (e) {
        attempts++;

        // se il documento non esiste o errore simile
        try {
          await creaProfiloSeNonEsiste(uid);
        } catch (_) {
          // ignoriamo errori di creazione e ritentiamo
        }

        // piccolo delay per evitare spam Firestore
        await Future.delayed(const Duration(milliseconds: 200));
      }
    }

    throw Exception(
        "Impossibile incrementare counter dopo $maxAttempts tentativi");
  }

  Stream<int> getUnreadCountStream(String uid) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((doc) {
      final data = doc.data();
      if (data == null) return 0;

      final value = data['toRead'];
      if (value == null) return 0;

      return (value as num).toInt();
    });
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

  Future<void> createAvvisoBenvenuto(String nome, String uid) async {
    String title = 'Ciao $nome, benvenuto su ParaLat!';
    String body =
        'Ciao $nome e benvenuto su ParaLat. Siamo lieti di accoglierti all\'interno della nostra community.\nTi informarmiamo che avrai a disposizione molteplici funzionalità totalmente gratuite e senza limite. Qualora avessi bisogno di ulteriori strumenti potrai abbonarti a ParaLat Premium in forma mensile o annuale\nIn caso di problemi con ParaLat siamo sempre a tua disposizione.\n\nUn saluto, il tuo ParaLat Team';
    CollectionReference reports = FirebaseFirestore.instance.collection('notifiche_personali');
    return reports
        .doc("Benvenuto_$uid")
        .set({
          'title': title,
          'body': body,
          'ora': FieldValue.serverTimestamp(),
          'letto': false,
        })
        .then((value) {
          incrementaCounter(uid, true);
        })
        .catchError((error) {});
    
  }

  // Future<void> deleteDocument(DocumentSnapshot documentSnapshot) async {
  //   try {
  //     // Ottieni la referenza del documento dal DocumentSnapshot
  //     final documentRef = documentSnapshot.reference;
  //     await documentRef.delete();
  //   } catch (e) {}
  // }

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

  String? getEmail() {
    User? utente = _firebaseAuth.currentUser;
    return utente!.email.toString();
  }

  Future<void> signOut(context) async {
    try {
      await _firebaseAuth.currentUser?.reload();
      await _firebaseAuth.signOut();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar("Errore durante il signout: $e",
            type: SnackBarType.error),
      );
    }
  }

  Future<void> markAsRead(BuildContext context, String docId) async {
    final docRef =
        FirebaseFirestore.instance.collection('notifiche_personali').doc(docId);
    try {
      await docRef.update({'letto': true});
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar("Errore nell'aggiornamento dei dati sulle notifiche",
            type: SnackBarType.error),
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
          customSnackBar(
            'Errore nell\'invio della mail di password reset\nCodice errore ${e.message}',
            type: SnackBarType.error,
          ),
        );
      }
    } else {
      try {
        await _firebaseAuth.sendPasswordResetEmail(email: email);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          customSnackBar(
              'Errore nell\'invio della mail di password reset\nCodice errore ${e.message}',
              type: SnackBarType.error),
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
        customSnackBar(
          'Errore nell\'eliminazione dell\'account\nCodice errore ${e.message}',
          type: SnackBarType.error,
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
        customSnackBar(
            'Errore nell\'invio della mail di password reset\nCodice errore ${e.message}',
            type: SnackBarType.error),
      );
    }
    return null;
  }

  Future<void> creaNotifiche(String uid) async {
    final db = FirebaseFirestore.instance;

    try {
      final now = DateTime.now();
      final limite = Timestamp.fromDate(
        now.subtract(const Duration(days: 14)),
      );

      final querySnapshot = await db
          .collection('avvisi')
          .where('ora', isGreaterThanOrEqualTo: limite)
          .get();

      for (var doc in querySnapshot.docs) {
        final data = doc.data();

        final idNotifica = '${doc.id}_$uid';

        final notificaRef =
            db.collection('notifiche_personali').doc(idNotifica);

        final notificaSnap = await notificaRef.get();

        // 🔴 già esiste → non fare nulla
        if (notificaSnap.exists) continue;

        // 🟢 crea notifica
        await notificaRef.set({
          'title': data['title'],
          'body': data['body'],
          'ora': data['ora'],
          'letto': false,
        });

        // 🔥 incrementa counter SOLO se creata davvero
        await incrementaCounter(uid, true);
      }

      print('Notifiche create correttamente');
    } catch (e) {
      print('Errore: $e');
    }
  }
}
