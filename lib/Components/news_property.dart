import 'package:flutter/material.dart';

class NewsProperty {
  Color setColor(String newsImportance) {
    if (newsImportance == 'red') {
      return Colors.red;
    } else if (newsImportance == 'yellow') {
      return Colors.yellow;
    } else if (newsImportance == 'purple') {
      return Colors.purple;
    } else {
      return Colors.purple;
    }
  }

  Color setScadColor(String colorScad) {
    switch (colorScad) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.yellow;
      case 'orange':
        return Colors.orange;
      case 'green':
        return Colors.green;
      case 'blue':
        return Colors.blue;
      case 'purple':
        return Colors.purple;
      case 'brown':
        return Colors.brown.shade600;
      default:
        return Colors.purple;
    }
  }
}
