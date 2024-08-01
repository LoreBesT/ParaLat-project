import 'package:flutter/material.dart';

class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Work in Progress'),
        toolbarHeight: 100,
        ),
      
      body: Container(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        child: Column(children: [
          const SizedBox(height: 100,width: double.maxFinite,),
          SizedBox(
            height: 350,
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                color: Theme.of(context).colorScheme.inversePrimary,
                elevation: 10,
                child: const Column(
                  children: [
                    Text('\n\nQuesta pagina non è ancora disponibile.\nIl nostro Team di sviluppo è al lavoro per rilasciarla quanto prima.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),textAlign: TextAlign.center,),
                    Padding(padding: EdgeInsets.only(bottom: 20)),
                    Padding(
                      padding: EdgeInsets.only(left:90),
                      child: Row(
                        children: [
                          Icon(Icons.emoji_people, size: 100,color: Colors.purple,),
                          Icon(Icons.settings, size: 100,color: Colors.purple,),
                        ],
                      ),
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