import 'package:flutter/material.dart';
import 'package:paralat/Components/Drawer_buttons.dart';
import 'package:paralat/screens/terms.dart';

class InfoappPage extends StatelessWidget {
  const InfoappPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            const Text('Versione 1.0.0',style: TextStyle(color: Colors.grey),),
            const SizedBox(height: 20,),
            Image.asset(r'assets\images\ParaLat.png'),
            const SizedBox(height: 20,),
            const Text('Tutti i diritti sono riservati',style: TextStyle(color: Colors.grey),),
            const SizedBox(height: 30,),
            SizedBox(
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
