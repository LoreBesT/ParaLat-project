import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';

class Tip extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const Tip(
      {super.key,
      required this.icon,
      required this.title,
      required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.1),
            borderRadius: AppRadius.circularBorder,
          ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.deepPurple.withOpacity(0.2),
            borderRadius: AppRadius.circularBorder,
          ),
          child: Icon(icon, color: Colors.deepPurple),
        ),
        title: Text(title,
            style: TextStyle(fontSize: 18, color: AppColors.text, fontWeight: FontWeight.w500)),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.deepPurple[400]),
        ),
      ),
    );
  }
}
