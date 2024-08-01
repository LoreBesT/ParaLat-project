import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class ArchivioPage extends StatefulWidget {
  const ArchivioPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ArchivioPageState createState() => _ArchivioPageState();
}

class _ArchivioPageState extends State<ArchivioPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<Reference> folders = [];
  bool isLoading = true;
  bool isPremium = true;

  @override
  void initState() {
    super.initState();
    listFolders();
  }

  Future<void> listFolders() async {
    try {
      // print('Tentativo di listare le cartelle nella cartella Versioni...');
      final ListResult result = await storage.ref('Versioni').listAll();
      // print('Risultato ottenuto: ${result.prefixes.length} cartelle trovate.');
      //  git remote add origin https://github.com/LoreBesT/ParaLat-App  
      setState(() {
        folders = result.prefixes;
        isLoading = false;
      });
    } catch (e) {
      // print('Errore nel listare le cartelle: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Archivio Versioni'),
        toolbarHeight: 100,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : folders.isEmpty
              ? const Center(child: Text('Nessuna cartella trovata.'))
              : ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    final folder = folders[index];
                    final folderName = folder.name;
                    return ListTile(
                      leading: const Icon(Icons.folder),
                      title: Text(folderName),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FolderPage(folderPath: 'Versioni/$folderName'),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}

class FolderPage extends StatefulWidget {
  final String folderPath;

  FolderPage({required this.folderPath});

  @override
  _FolderPageState createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<Reference> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    listItems();
  }

  Future<void> listItems() async {
    try {
      // print('Tentativo di listare gli elementi nella cartella ${widget.folderPath}...');
      final ListResult result = await storage.ref(widget.folderPath).listAll();
      // print('Risultato ottenuto: ${result.prefixes.length} cartelle e ${result.items.length} file trovati.');
      setState(() {
        items = result.prefixes + result.items;
        isLoading = false;
      });
    } catch (e) {
      // print('Errore nel listare gli elementi: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> downloadFile(String url, String fileName) async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderPath.split('/').last),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        toolbarHeight: 100,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
              ? const Center(child: Text('Nessun elemento trovato.'))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final itemName = item.name;
                    return ListTile(
                      title: Text(itemName),
                      trailing: item.name.contains('.')
                          ? 
                          IconButton(
                              icon: const Icon(Icons.download),
                              onPressed: () async {
                                final url = await item.getDownloadURL();
                                downloadFile(url, itemName);
                              },
                            )
                          : const Icon(Icons.arrow_forward),
                      onTap: !item.name.contains('.')
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FolderPage(
                                      folderPath:
                                          '${widget.folderPath}/$itemName'),
                                ),
                              );
                            }
                          : null,
                    );
                  },
                ),
    );
  }
}
