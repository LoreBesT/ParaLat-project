import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/screens/HomePage.dart';
import 'package:paralat/screens/impostazioni_page_2.dart';
import 'package:paralat/screens/news_general_page.dart';
import 'package:paralat/screens/paralatAI_page.dart';
import 'package:paralat/screens/work_page.dart';
//COMPLETARE QUESTA PAGINA E REPUTAZIONE PAGE

class Verify {
  // String adminUser = 'Official Member ParaLat Team';
  // String freeUser = 'Free ParaLat User';
  // String premiumUser = 'Premium ParaLat User';
  List<String> premiumUsers = []; //Prendere i premium users dal cloud

  String typeUser(int i) {
    switch (i) {
      case 0:
        return 'Premium ParaLat User';
      case 1:
        return 'Free ParaLat User';
      default:
        return 'Errore 404, livello non trovato';
    }
  }

  ///Function to verify if a user is admin, free or premium
  String verifyUser(context) {
    String? currentEmail = Auth().metaDatas(context, 2);
    if (currentEmail != null && currentEmail != 'null') {
      return typeUser(1);
    } else {
      return '';
    }
  }

  List<Widget>? funzioniBottAppBar(BuildContext context) {
    return [const GeminiApiPage(), const WorkPage(), const NewsGeneralPage(), const ImpostazioniPage2()];
  }

  ///Function to set the icon for admin, free and premium users
  IconData setIcon(context) {
    if (verifyUser(context) == typeUser(0) ||
        verifyUser(context) == typeUser(1)) {
      return Icons.verified;
    } else {
      return Icons.no_accounts;
    }
  }

  ///Function to set icon color of admin, free, premium user's icon.
  Color setColor(context) {
    if (verifyUser(context) == typeUser(0)) {
      return Colors.green;
    } else if (verifyUser(context) == typeUser(1)) {
      return const Color.fromARGB(255, 221, 102, 242);
    } else {
      return const Color.fromARGB(255, 255, 153, 0);
    }
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

  bool isPremium(context) {
    if (Verify().verifyUser(context) == typeUser(0)) {
      return true;
    } else {
      return false;
    }
  }
}
