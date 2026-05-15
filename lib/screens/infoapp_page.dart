import 'package:flutter/material.dart';
import 'package:paralat/Components/drawer_buttons/drawerButton.dart';
import 'package:paralat/screens/terms.dart';
import 'package:paralat/Components/level_user.dart';

class InfoappPage extends StatelessWidget {
  const InfoappPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              'ParaLat App',
              style: TextStyle(fontSize: 24),
            ),
            FutureBuilder<String>(
              future: Verify().getVersion(0),
              builder: (context, snapshot) {
                final versionText = snapshot.connectionState == ConnectionState.done && snapshot.hasData
                    ? snapshot.data
                    : '...';
                return Text(
                  'Versione $versionText',
                  style: const TextStyle(color: Colors.grey),
                );
              },
            ),
            const SizedBox(height: 20,),
            Image.asset(r'assets/images/ParaLat.png'),
            const SizedBox(height: 20,),
            const Text('Tutti i diritti sono riservati',style: TextStyle(color: Colors.grey),),
            const SizedBox(height: 30,),
            const SizedBox(
              width: 150,
                child: Button(
                    icona: Icons.info_outline_rounded,
                    funzione: TermsPage(),
                    testo: 'Licenze')),
          ],
        ),
      ),
    );
  }
}
