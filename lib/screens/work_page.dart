import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Auth().isDarkTheme(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work in Progress'),
        ),
      
      body: Container(
        color: const Color.fromARGB(255, 31, 24, 43),

        child: const Column(children: [
          SizedBox(height: 100,width: double.maxFinite,),
          SizedBox(
            height: 350,
            width: double.maxFinite,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: Color.fromARGB(255, 211, 188, 253),
                // elevation: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('\nQuesta pagina non è ancora disponibile.\nIl nostro Team di sviluppo è al lavoro per rilasciarla quanto prima.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),textAlign: TextAlign.center,),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.emoji_people, size: 100, color: Colors.deepPurple,),
                        Icon(Icons.settings, size: 100, color: Colors.deepPurple,),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],),
      ),
    );
  }
}