import 'package:flutter/material.dart';
import 'package:paralat/Components/appUiStandards.dart';
import 'package:paralat/Components/socialLinks.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: AppRadius.circularBorder,
        border: Border.all(
          color: AppColors.gradientStart.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔝 Header
          Row(
            children: [
              CircleAvatar(
                radius: 24, // 30 / 2
                child: Image.asset(
                  'assets/images/logoApp.png',
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Supporta ParaLat",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Aiutaci a migliorare l'app",
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.gradientStart,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // 🔥 Bottone FIXATO
          SizedBox(
            width: double.infinity,
            child: Material(
              color: Colors.transparent, // 🔑 fondamentale
              child: InkWell(
                onTap: () {
                  openSite(context, "https://ko-fi.com/paralatstudy");
                },
                borderRadius: BorderRadius.circular(30),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.gradientStart,
                        AppColors.gradientEnd,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.favorite_border, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Fai una donazione",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
