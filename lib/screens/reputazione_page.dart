import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/Components/level_user.dart';

class ProfiloPage extends StatefulWidget {
  const ProfiloPage({super.key});

  @override
  State<ProfiloPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ProfiloPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Ciao ${Verify().nameUser(0)}'), //.animate(effects: [ ]), //RICORDA DI INSERIRE ANIMAZIONE AL NOME
      ),
      body: SingleChildScrollView(
        child: Align(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                margin: const EdgeInsets.all(8),
                elevation: 2,
                child: Column(
                  children: [
                    ListTile(
                      title: Text(Verify().nameUser(4)),
                      subtitle: Text(Verify().verifyUser(context)),
                      leading: const Icon(Icons.person),
                      trailing: Icon(
                        Verify().setIcon(context),
                        color: Verify().setColor(context),
                        size: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () {
                        Auth().reimpostaPassword(context, false);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text(
                              'Email inviata con successo',
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.inversePrimary,
                          ),
                        );
                      },
                      child: const Text('Reimposta Password'))),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                  'Dati account',
                                  textAlign: TextAlign.center,
                                ),
                                content: SizedBox(
                                  height: 278,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Utente: ${Auth().getUserDisplayName()}\nEmail: ${Auth().metaDatas(context, 2)}\nID account:\n${Auth().metaDatas(context, 3)}\nUltimo accesso: ${Auth().metaDatas(context, 1)}\nData creazione account: ${Auth().metaDatas(context, 0)}',
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width: 150,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Ok')),
                                      ),
                                    ],
                                  ),
                                )));
                      },
                      child: const Text('Visualizza dati account'))),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () {
                        Auth().signOut(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Esci',
                        style: TextStyle(color: Colors.red),
                      ))),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  child: ElevatedButton(
                      onPressed: () {
                        Auth().deleteAccount(context);
                        Auth().signOut(context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Elimina account',
                        style: TextStyle(color: Colors.red),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
