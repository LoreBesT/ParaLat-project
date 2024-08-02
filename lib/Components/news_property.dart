import 'package:flutter/material.dart';

class NewsProperty {
  Color setColor(String newsImportance) {
    if (newsImportance == 'max') {
      return Colors.red;
    } else if (newsImportance == 'medium') {
      return Colors.yellow;
    } else if (newsImportance == 'min') {
      return Colors.green;
    }  else {
      return Colors.green;
    }
  }
}
