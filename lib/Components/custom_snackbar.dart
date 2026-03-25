import 'package:flutter/material.dart';

SnackBar customSnackBar(String message, {SnackBarType type = SnackBarType.error}) {
  Color bgColor;
  IconData icon;

  switch (type) {
    case SnackBarType.success:
      bgColor = Colors.green.shade600;
      icon = Icons.check_circle_outline;
      break;
    case SnackBarType.info:
      bgColor = Colors.blue.shade600;
      icon = Icons.info_outline;
      break;
    case SnackBarType.error:
    default:
      bgColor = Colors.red.shade700;
      icon = Icons.error_outline;
      break;
  }

  return SnackBar(
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    content: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    ),
    duration: Duration(seconds: 3),
  );
}

// Enum per tipologia
enum SnackBarType { error, success, info }