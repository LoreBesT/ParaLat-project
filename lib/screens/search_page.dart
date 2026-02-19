import 'package:flutter/material.dart';
import 'package:paralat/Components/action_buttons.dart';
import 'package:paralat/Components/feed.dart';
import 'package:paralat/screens/archivio_page.dart';
import 'package:paralat/screens/work_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _versione = TextEditingController();
  bool isLoading = false;
  bool isSearch = false;
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Versioni e Appunti'),
        toolbarHeight: 130,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 80,
                  width: double.infinity,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: TextField(
                      controller: _versione,
                      autocorrect: false,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        // Impedisce la sovrapposizione quando si inizia a scrivere
                        hintText: 'Scrivi',
                        hintStyle: const TextStyle(fontSize: 20),
                        border: const OutlineInputBorder(),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // Padding modificato per evitare la sovrapposizione
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        suffixIcon: isLoading
                            ? const CircularProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isSearch = !isSearch;
                                    });
                                    setState(() {
                                      isLoading = !isLoading;
                                    });
                                    FocusScope.of(context).unfocus();
                                    // Auth().searchInFirestore(_versione.text);
                                    //Completare realizzando una pagina con una serie di ListTile
                                    //Quando premuto il cerca manda alla pagina listTile
                                    //Qui si potrà premere ogni singola listtile che usando i dati del firestore ricostruirà il percorso del documento su storage.
                                    if (_versione.text.isNotEmpty) {
                                      _versione.clear();
                                    }
                                  },
                                  icon: const Icon(
                                    Icons.search,
                                    size: 30,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ActionButtons(
                      icona: Icons.upload,
                      testoMinuscolo: 'Carica una versione',
                      testoMaiuscolo: 'PER LA COMMUNITY',
                      funzione: WorkPage(),
                    ),
                    ActionButtons(
                      icona: Icons.search_off,
                      testoMinuscolo: 'Nessun Risultato?',
                      testoMaiuscolo: 'PROVA LA RICERCA MANUALE',
                      funzione: ArchivioPage(),
                    ),
                    ActionButtons(
                      icona: Icons.camera_alt,
                      testoMinuscolo: 'Cerca con la versione',
                      testoMaiuscolo: 'FOTOCAMERA',
                      funzione: WorkPage(),
                    ),
                    ActionButtons(
                      icona: Icons.filter_alt_rounded,
                      testoMinuscolo: 'Affina la ricerca',
                      testoMaiuscolo: 'INSERISCI DEI FILTRI',
                      funzione: WorkPage(),
                    ),
                    ActionButtons(
                      icona: Icons.report,
                      testoMinuscolo: 'Segnalaci un errore',
                      testoMaiuscolo: 'NELLE VERSIONI ',
                      funzione: WorkPage(),
                    ),
                  ],
                ),
                //Creare una lista delle versioni ParaLat Originals. Trovare un index randomico per ognuna così da metterle nel feed in posizioni casuali ogni volta.
              ),
              isSearch 
              ? SizedBox(
                height: 250,
                child: Card(
                  elevation: 4,
                  child: Scrollbar(
                    controller: _scrollController,
                    child: ListView(
                      controller: _scrollController,
                      children: const [],
                    ),
                  ),
                ),
              ) 
              : const Feed(),
            ],
          ),
        ),
      ),
    );
  }
}
