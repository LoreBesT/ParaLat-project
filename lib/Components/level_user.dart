// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/screens/impostazioni_page_2.dart';
import 'package:paralat/screens/news_general_page.dart';
import 'package:paralat/screens/paralatAI_page.dart';
import 'package:paralat/screens/work_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
//COMPLETARE QUESTA PAGINA E REPUTAZIONE PAGE

class Verify {

  List<Widget>? funzioniBottAppBar(BuildContext context) {
    return [
      const GeminiApiPage(),
      const WorkPage(),
      const NewsGeneralPage(),
      const ImpostazioniPage2()
    ];
  }

  Future<String> getVersion(int type) async {
    final info = await PackageInfo.fromPlatform();
    return (type == 0) ? info.version.toString() : info.buildNumber.toString();
  }

  ///Function to find the user name. For every index there is a different type of return name.
  ///
  ///For i = 0 the function returns only the name
  ///
  ///For i = 1 the function returns the second word(secondo name, first surname, surname)
  ///
  ///For i = 2 the function returns the first and second word
  ///
  ///For i = 4 the function returns the complete name and surname
  ///
  ///For i = 5 the function returns the first letter of name
  ///
  ///For default the function returns the complete name and surname
  String nameUser(int i) {
    String? nome = Auth().getUserDisplayName();
    List<String> nomeCognome = nome!.split(' ');

    switch (i) {
      case 0:
        if (nomeCognome.length >= 2 && nomeCognome[0] != 'null') {
          return nomeCognome[0];
        } else {
          return '';
        }

      case 1:
        return nomeCognome[1];
      case 2:
        return ('${nomeCognome[1]} ${nomeCognome[2]}');
      case 3:
        return nome;
      case 4:
        return nome[0];
      default:
        return nome;
    }
  }
}
