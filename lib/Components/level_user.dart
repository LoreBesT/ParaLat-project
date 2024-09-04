import 'package:flutter/material.dart';
import 'package:paralat/Components/auth.dart';
import 'package:paralat/screens/HomePage.dart';
import 'package:paralat/screens/impostazioni_page.dart';
import 'package:paralat/screens/news_general_page.dart';
import 'package:paralat/screens/news_page.dart';
//COMPLETARE QUESTA PAGINA E REPUTAZIONE PAGE

class Verify {
  // String adminUser = 'Official Member ParaLat Team';
  // String freeUser = 'Free ParaLat User';
  // String premiumUser = 'Premium ParaLat User';
  List<String> premiumUsers = []; //Prendere i premium users dal cloud
  List<String> adminUsers = [
    'lorenzodellabona06@gmail.com',
    'nicolepastore06@gmail.com',
    'mario',
    'jacopoleo0326@gmail.com',
    'letiziamarzo6@gmail.com',
    'lucama2802@gmail.com',
    'francescabariletto13@gmail.com',
    'annamariaalba19@gmail.com'
  ];

  String typeUser(int i) {
    switch (i) {
      case 0:
        return 'Official Member ParaLat Team';
      case 1:
        return 'Premium ParaLat User';
      case 2:
        return 'Free ParaLat User';
      default:
        return 'Free ParaLat User';
    }
  }

  ///Function to verify if a user is admin, free or premium
  String verifyUser(context) {
    String? currentEmail = Auth().metaDatas(context, 2);

    for (var user in adminUsers) {
      if (user == currentEmail) {
        return typeUser(0);
      }
    }

    if (currentEmail != null && currentEmail != 'null') {
      return typeUser(2);
    } else {
      return 'Guest'; // Rimuovere non esistono più i guest
    }
  }

  List<Widget>? funzioniBottAppBar(BuildContext context) {
    if (Verify().verifyUser(context) == typeUser(0)) {
      return [HomePage(), NewsPage(), ImpostazioniPage()];
    } else {
      return [HomePage(), NewsGeneralPage(), ImpostazioniPage()];
    }
  }

  ///Function to set the icon for admin, free and premium users
  IconData setIcon(context) {
    if (verifyUser(context) == typeUser(0)) {
      return Icons.verified;
    } else if (verifyUser(context) == typeUser(2)) {
      return Icons.verified;
    } else {
      return Icons.no_accounts;
    }
  }

  ///Function to set icon color of admin, free, premium user's icon.
  Color setColor(context) {
    if (verifyUser(context) == typeUser(0)) {
      return Colors.green;
    } else if (verifyUser(context) == typeUser(2)) {
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
  ///For i = 3 the function returns guest
  ///
  ///For i > 3 the function measures the lenght of listname and returns name and surname completely
  String nameUser(int i) {
    String? nome = Auth().getUserDisplayName();
    String guest = 'Guest'; //Rimuovere
    List<String> nomeCognome = nome!.split(' ');

    switch (i) {
      case 0:
        if (nomeCognome.length >= 2 && nomeCognome[0] != 'null') {
          return nomeCognome[0];
        } else {
          return guest;
        }

      case 1:
        return nomeCognome[1];
      case 2:
        return ('${nomeCognome[1]} ${nomeCognome[2]}');
      case 3:
        return guest;
      case 4:
        return nome;
      default:
        if (nomeCognome.length == 2) {
          return '${nomeCognome[0]} ${nomeCognome[1]}';
        } else if (nomeCognome.length == 1 && nomeCognome[0] != 'null') {
          return nomeCognome[0];
        } else if (nomeCognome.length == 3) {
          return '${nomeCognome[0]} ${nomeCognome[1]} ${nomeCognome[2]}';
        } else {
          return guest;
        }
    }
  }

  bool isPremium(context) {
    if (Verify().verifyUser(context) == typeUser(1) ||
        Verify().verifyUser(context) == typeUser(0)) {
      return true;
    } else {
      return false;
    }
  }
}
