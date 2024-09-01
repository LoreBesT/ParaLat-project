import 'package:flutter/material.dart';

class NewsProperty {
  Color setScadColor(String colorScad) {
    switch (colorScad) {
      case 'rosso':
      case 'red':
        return Colors.red;
      case 'giallo':
      case 'yellow':
        return Colors.yellow;
      case 'arancione':
      case 'orange':
        return Colors.orange;
      case 'verde':
      case 'green':
        return Colors.green;
      case 'blu':
      case 'blue':
        return Colors.blue;
      case 'viola':
      case 'purple':
        return Colors.purple;
      case 'marrone':
      case 'brown':
        return Colors.brown.shade600;
      case 'rosa':
      case 'pink':
        return Colors.pink;
      case 'nero':
      case 'black':
        return Colors.black;
      case 'ciano':
      case 'cyan':
        return Colors.cyan;
      default:
        return Colors.purple;
    }
  }
}
