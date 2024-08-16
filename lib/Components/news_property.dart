import 'package:flutter/material.dart';

class NewsProperty {
  Color setColor(String newsImportance) {
    if (newsImportance == 'max') {
      return Colors.red;
    } else if (newsImportance == 'medium') {
      return Colors.yellow;
    } else if (newsImportance == 'min') {
      return Colors.green;
    } else {
      return Colors.green;
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
      default:
        return Colors.purple;
    }
  }
}
