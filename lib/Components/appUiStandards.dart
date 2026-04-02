import 'package:flutter/material.dart';

class AppColors {
  static const Color gradientStart = Color(0xFF9839ff); // viola
  static const Color gradientEnd = Color.fromARGB(255, 237, 7, 241); // fucsia
  static Color successGreen = Colors.green.shade600;
  static Color errorRed = Colors.red.shade600;
  static Color infoBlue = Colors.blue.shade700;
  static const Color cardTile = Color.fromRGBO(236, 236, 249, 1);
  static const Color text = Color.fromARGB(255, 88, 22, 139);
}

class AppRadius {
  static const double circular = 14.0;
  static const BorderRadius circularBorder =
      BorderRadius.all(Radius.circular(circular));
}

class DesignSettings {
  Widget sectionTile({
  required String title,
  required IconData icon,
  int? badgeCount,
}) {
  return Stack(
    alignment: Alignment.centerLeft, // Allinea verticalmente al centro
    children: [
      // 1. Contenitore principale che occupa tutta la larghezza
      SizedBox(
        width: double.infinity, 
        height: 40, // Definisci un'altezza coerente per la riga
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: AppColors.gradientStart,
            ),
            const SizedBox(width: 10),
            // Expanded impedisce l'overflow se il titolo è troppo lungo
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.text,
                ),
              ),
            ),
            // Spazio vuoto a destra per non far finire il testo sotto il badge
            const SizedBox(width: 50), 
          ],
        ),
      ),

      // 2. Il Badge ancorato esattamente a 10px dal bordo destro
      if (badgeCount != null && badgeCount > 0)
        Positioned(
          right: 0, 
          // Centriamolo verticalmente (se l'altezza dello stack è 40 e il badge ~20, top: 10 lo centra)
          top: 10, 
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            constraints: const BoxConstraints(
              minWidth: 28,
              minHeight: 18,
            ),
            child: Center(
              child: Text(
                badgeCount.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
    ],
  );
}
}
